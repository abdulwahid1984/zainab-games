# Zainab Games

A colorful, phone-friendly family game night website hosted on GitHub Pages.

## Games

The home page puts original mini-games inspired by 2026 kids' favorites first, followed by quick-play, board, online, and adventure games. The catalog includes Block Pop Builder, Goal Stars, Jungle Obby Dash, Candy Pop, Turbo Racers, Ludo, Sky Island Survival, Tic-Tac-Toe, Connect Four, and more. Rainbow Archery is a playable 10 m and 15 m archery range with draw-and-release shooting, adjustable aim, and wind. Cosmic Defender adds five escalating mobile-friendly waves; Chef's Rush adds timed order-combo levels. The redesigned arcade includes search, saved favorites, motion, and a local daily XP challenge. These are original web games, not ports of commercial games.

## Profiles, friends, and chat

Email-only passwordless sign-in creates a starter player name; users can change the name or avatar later. Guest play is available without registering. Signed-in players see live lobby presence and can send a challenge using a private game invite.

Family chat rooms use a one-time 8-character code and expire after 12 hours. Messages are friendly preset phrases only, are not stored, and can also be used during a game. Sign-in links must allow `https://abdulwahid1984.github.io/zainab-games/` in Supabase Auth. The Supabase publishable key in `supabase-config.js` is intended for browser use; never put a secret or service-role key in this file.

## Rooms, voice, and files

Create a friend room and share its invite URL. PeerJS connects the players; voice and file sharing go directly between connected browsers. Voice needs microphone permission. Files are limited to 5 MB and are not stored.

## Hosting and database

GitHub Pages uses `.github/workflows/pages.yml`; commits to `main` trigger deployment. `supabase/schema.sql` documents the database schema applied to the connected Supabase project, including row-level security for profiles, matchmaking, private matches, and social rooms.
