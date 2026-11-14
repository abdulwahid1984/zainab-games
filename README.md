# Zainab Games

A mobile friendly arcade site with seven fast, touch focused games. Every game has 15 stages, saved scorecards, and replay for unlocked stages.

## New arcade lineup

- Neon Kart Clash: switch lanes, dodge hazards, and use boosts.
- Star Blaster Arena: tap moving drones through increasingly busy waves.
- Jungle Rush Squad: jump and dodge through a colorful runner.
- Snake Royale: guide a growing snake through the arena.
- Card Quest Arena: find matching pairs before your moves run out.
- Rhythm Jump: follow the tune and help the bunny reach the goal.
- Chess Masters: play against the computer, pass-and-play, or challenge someone online.

Use the game cards to choose Solo, local 2 player, local 4 player, or an online family room. Local party modes pass the same device and compare round scores. Online arcade rooms broadcast challenge starts and score results; everyone plays the same stage on their own device. Online chess sends moves through the shared room.

Scorecards are saved in browser storage for the signed-in profile or guest identity on that device. They do not currently sync between devices.

## Hosting

GitHub Pages deploys from `main` using `.github/workflows/pages.yml`. The page uses the existing Supabase Realtime connection for family-room presence, challenge events, and chess moves. Set the Supabase Auth allowed redirect URL to `https://abdulwahid1984.github.io/zainab-games/`. `supabase-config.js` contains only the public browser key; never place a service-role key there.
