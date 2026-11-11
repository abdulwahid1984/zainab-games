-- Zainab Games account, avatar, and worldwide matchmaking schema.
create extension if not exists pgcrypto;

create table if not exists public.profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  username text not null unique check (char_length(username) between 2 and 24),
  avatar_url text,
  updated_at timestamptz not null default now()
);
alter table public.profiles enable row level security;
grant select on public.profiles to anon, authenticated;
grant insert, update on public.profiles to authenticated;
drop policy if exists "profiles are visible to players" on public.profiles;
create policy "profiles are visible to players" on public.profiles for select to anon, authenticated using (true);
drop policy if exists "players create their own profile" on public.profiles;
create policy "players create their own profile" on public.profiles for insert to authenticated with check (user_id = (select auth.uid()));
drop policy if exists "players update their own profile" on public.profiles;
create policy "players update their own profile" on public.profiles for update to authenticated using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('avatars', 'avatars', true, 5242880, array['image/jpeg','image/png','image/webp'])
on conflict (id) do update set public = true, file_size_limit = 5242880, allowed_mime_types = array['image/jpeg','image/png','image/webp'];
drop policy if exists "avatar pictures are public" on storage.objects;
create policy "avatar pictures are public" on storage.objects for select to anon, authenticated using (bucket_id = 'avatars');
drop policy if exists "players upload their own avatar" on storage.objects;
create policy "players upload their own avatar" on storage.objects for insert to authenticated with check (bucket_id = 'avatars' and (storage.foldername(name))[1] = (select auth.uid())::text);
drop policy if exists "players update their own avatar" on storage.objects;
create policy "players update their own avatar" on storage.objects for update to authenticated using (bucket_id = 'avatars' and (storage.foldername(name))[1] = (select auth.uid())::text) with check (bucket_id = 'avatars' and (storage.foldername(name))[1] = (select auth.uid())::text);
drop policy if exists "players delete their own avatar" on storage.objects;
create policy "players delete their own avatar" on storage.objects for delete to authenticated using (bucket_id = 'avatars' and (storage.foldername(name))[1] = (select auth.uid())::text);

create table if not exists public.match_queue (
  user_id uuid primary key references auth.users(id) on delete cascade,
  game text not null check (game in ('Tic-Tac-Toe','Connect Four','Dot Dash','Guess & Grab','Word Race')),
  status text not null default 'waiting' check (status in ('waiting','matched')),
  match_id uuid,
  role text check (role in ('X','O')),
  joined_at timestamptz not null default now()
);
alter table public.match_queue enable row level security;
grant select on public.match_queue to authenticated;
drop policy if exists "players see their own queue entry" on public.match_queue;
create policy "players see their own queue entry" on public.match_queue for select to authenticated using (user_id = (select auth.uid()));

create table if not exists public.matches (
  id uuid primary key default gen_random_uuid(),
  game text not null check (game in ('Tic-Tac-Toe','Connect Four','Dot Dash','Guess & Grab','Word Race')),
  player_x uuid not null references auth.users(id) on delete cascade,
  player_o uuid not null references auth.users(id) on delete cascade,
  state jsonb not null default '{}'::jsonb,
  status text not null default 'playing' check (status in ('playing','finished','cancelled')),
  created_at timestamptz not null default now(),
  check (player_x <> player_o)
);
create index if not exists matches_player_x_idx on public.matches (player_x);
create index if not exists matches_player_o_idx on public.matches (player_o);
create index if not exists match_queue_waiting_game_joined_idx on public.match_queue (game, joined_at) where status = 'waiting';
alter table public.matches enable row level security;
grant select on public.matches to authenticated;
drop policy if exists "players can read their match" on public.matches;
create policy "players can read their match" on public.matches for select to authenticated using ((select auth.uid()) in (player_x, player_o));

create or replace function public.join_matchmaking(p_game text)
returns table(status text, match_id uuid, role text)
language plpgsql security definer set search_path = public
as $$
declare
  v_user uuid := auth.uid();
  v_opponent uuid;
  v_match uuid;
begin
  if v_user is null then raise exception 'Sign in first'; end if;
  if p_game not in ('Tic-Tac-Toe','Connect Four','Dot Dash','Guess & Grab','Word Race') then raise exception 'Game is not available for matchmaking'; end if;

  delete from public.match_queue q where q.user_id = v_user;
  select q.user_id into v_opponent
  from public.match_queue q
  where q.game = p_game and q.status = 'waiting' and q.user_id <> v_user
  order by q.joined_at
  for update skip locked limit 1;

  if v_opponent is null then
    insert into public.match_queue (user_id, game, status, match_id, role, joined_at)
    values (v_user, p_game, 'waiting', null, null, now());
    return query select 'waiting'::text, null::uuid, null::text;
    return;
  end if;

  insert into public.matches (game, player_x, player_o)
  values (p_game, v_opponent, v_user)
  returning id into v_match;

  update public.match_queue q set status = 'matched', match_id = v_match, role = 'X'
  where q.user_id = v_opponent;
  insert into public.match_queue (user_id, game, status, match_id, role, joined_at)
  values (v_user, p_game, 'matched', v_match, 'O', now());
  return query select 'matched'::text, v_match, 'O'::text;
end;
$$;
grant execute on function public.join_matchmaking(text) to authenticated;
revoke all on function public.join_matchmaking(text) from public, anon;

create or replace function public.cancel_matchmaking()
returns void language sql security definer set search_path = public
as $$ delete from public.match_queue where user_id = auth.uid() and status = 'waiting'; $$;
grant execute on function public.cancel_matchmaking() to authenticated;
revoke all on function public.cancel_matchmaking() from public, anon;

create or replace function public.update_match_state(p_match_id uuid, p_state jsonb)
returns void language plpgsql security definer set search_path = public
as $$
begin
  if auth.uid() is null then raise exception 'Sign in first'; end if;
  update public.matches m set state = p_state
  where m.id = p_match_id and m.status = 'playing'
    and (m.player_x = auth.uid() or m.player_o = auth.uid());
  if not found then raise exception 'Match is no longer available'; end if;
end;
$$;
grant execute on function public.update_match_state(uuid, jsonb) to authenticated;
revoke all on function public.update_match_state(uuid, jsonb) from public, anon;

do $$
begin
  alter publication supabase_realtime add table public.matches;
exception when duplicate_object then null;
end $$;

