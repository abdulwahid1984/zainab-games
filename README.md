# Zainab Games

A colorful, mobile-friendly family game night website published with GitHub Pages.

## Games

Five room games sync turns between two browsers: Tic-Tac-Toe, Connect Four, Dot Dash, Guess & Grab, and Word Race. Nine quick party games can be played locally or pass-and-play: Memory Match, Rock Paper Scissors, Dice Duel, Quick Quiz, Lucky Spinner, Heads or Tails, Color Tap, Number Ninja, and Word Scramble.

## Rooms, voice, and files

Create a room and share its invite URL. The host must keep the room open while the other player joins. PeerJS provides signaling and WebRTC peer connections; voice and files go directly between connected browsers. Voice requires HTTPS and microphone permission. File sharing is limited to 5 MB in this demo, and files are not stored. Connection availability depends on the public PeerJS cloud and the players' networks.

## Hosting

GitHub Pages uses the workflow in `.github/workflows/pages.yml`. New commits to `main` trigger a deployment.

