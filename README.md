# Zainab Games

A colorful, mobile-friendly family game night website hosted on GitHub Pages.

## Games

Five games support computer opponents, private friend rooms, and worldwide matchmaking: Tic-Tac-Toe, Connect Four, Dot Dash, Guess & Grab, and Word Race. Nine quick party games are available locally or in pass-and-play: Memory Match, Rock Paper Scissors, Dice Duel, Quick Quiz, Lucky Spinner, Heads or Tails, Color Tap, Number Ninja, and Word Scramble. Sound effects can be switched off.

## Accounts and worldwide play

Supabase Auth supports passwordless email sign-in. The site stores a public nickname and optional avatar; avatars are restricted to image files up to 5 MB. RLS policies restrict profile edits to the signed-in owner, and match state is only visible to the two players. Worldwide matchmaking pairs signed-in players in the same game. The Supabase publishable key in `supabase-config.js` is intended for browser use; never put a secret or service-role key in this file.

To allow email sign-in links to return to GitHub Pages, set the Supabase Auth Site URL to `https://abdulwahid1984.github.io/zainab-games/` and add that URL to the redirect allow list. Phone sign-in also needs an SMS provider configured in Supabase Auth; until one is configured, use email sign-in.

## Rooms, voice, and files

Create a room and share its invite URL. The host must keep the room open while the other player joins. PeerJS provides signaling and WebRTC peer connections; voice and files go directly between connected browsers. Voice requires HTTPS and microphone permission. File sharing is limited to 5 MB and files are not stored. These tools are available for private rooms. Connection availability depends on the public PeerJS cloud and players' networks.

## Hosting

GitHub Pages uses `.github/workflows/pages.yml`. New commits to `main` trigger deployment. `supabase/schema.sql` documents the database schema applied to the connected Supabase project.

