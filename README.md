# Zainab Games

A mobile-friendly, single-page game night website. Open `index.html` locally to try the games.

## What is included

- Ten quick games: Tic-Tac-Toe, Memory Match, Rock Paper Scissors, Dice Duel, Guess the Number, Quick Quiz, Word Scramble, Lucky Spinner, Heads or Tails, and Color Tap.
- Room invite links with a room code.
- PeerJS/WebRTC voice and direct file transfer (up to 5 MB per file in this demo).
- Responsive layout for phones and desktop browsers.

## Free hosting

The site is static and can be published on GitHub Pages at no hosting charge for a public repository. Create a public GitHub repository, upload `index.html`, then in **Settings → Pages** select deployment from the `main` branch and root folder. GitHub will show the published URL when the deployment finishes. Rename the repository to `zainab-games` if you want a matching project URL.

Voice requires the site to be served over HTTPS and users to allow microphone access. The room host needs to open the room before guests join. The PeerJS public cloud is used for connection signaling; voice and files travel peer-to-peer. PeerJS cloud availability and browser/network restrictions can affect connections.

## Current scope

Games are playable locally in each browser (or pass-and-play on one phone). Room membership does not yet synchronize game turns or scores across devices. Files are sent directly and are not stored. This starter does not include accounts, moderation, or a persistent chat history.

