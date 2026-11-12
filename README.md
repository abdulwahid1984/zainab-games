# Zainab Games

Zainab Games is a phone-friendly arcade and family game site hosted on GitHub Pages.

## Action games

The redesigned arcade puts action, racing, and adventure missions first. New original games include Neon Squad: Drone Ops (a moving arena with five waves), Drift Circuit X (lane racing with obstacles and nitro), and Dungeon Raiders (a multi-floor dungeon run). The showcased lineup also includes arcade racing, obstacle runs, goal shooting, archery at 10 m and 15 m, survival, and family board games. Games use original web mechanics and artwork rather than commercial game assets.

## Play with family

Use **Play with family** to create a room and copy its invite link. Open the link on another phone or computer, then choose a two-player game. Moves and preset cheers travel over Supabase Realtime; PeerJS remains as a fallback where realtime cannot connect. The invite has a random 128-bit room token and expires after four hours. Anyone with the link can enter until it expires, so share it only with the people you want in the room.

Online board games also offer computer play. Worldwide matchmaking and live player profiles require email sign-in. Voice and file sharing use the direct PeerJS connection when available; microphone permission is needed for voice and files are limited to 5 MB.

## Profiles and child-friendly chat

Guest play does not require registration. Email sign-in enables a player name, avatar, and worldwide matchmaking; guests appear in the online lobby with a temporary nickname. Family group rooms use a 12-character code or copied invite link and expire after 12 hours. Guests can see other online nicknames and use live lobby, family-room, and in-game text chat without signing in. Messages are limited to 240 characters and sent as plain text. Seven new 15-stage campaigns add Chess Masters, Doll Dress-Up Studio, Makeup Magic Studio, Card Quest, Piano Jump, Jungle Run, and Snake Evolution. Unlocked stages, saved high scores, and the next stage are kept per browser, tied to the signed-in profile or a persistent guest identity.

## Coloring and sound

Coloring Art Studio has 15 searchable pictures, fill, brush and eraser tools, undo, clear, and PNG save. The Music toggle starts gentle site ambience and switches to a livelier game melody while playing; short sound effects respond to turns and actions. Posters have subtle motion and respect reduced-motion settings.

## Hosting and configuration

GitHub Pages deploys from `main` using `.github/workflows/pages.yml`. Set the Supabase Auth allowed redirect URL to `https://abdulwahid1984.github.io/zainab-games/`. `supabase-config.js` contains only the public browser key; never place a service-role key there.

The database schema and setup notes are in `supabase/schema.sql` and `supabase/social-chat.sql`.






