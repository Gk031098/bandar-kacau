# Bandar Kacau

A 3D open-city game that runs in the browser. Steal cars, take jobs from the yellow phones, hit stunt ramps, and outrun the Polis. You can rewind time when things go wrong.

The online features run on [Supabase](https://supabase.com):

- **Cloud save:** your cash, finished jobs and best jump follow you between visits.
- **Leaderboard:** shows the richest players and the biggest stunt jumps.
- **Live multiplayer:** everyone playing at the same moment shares one city. You can see each other's cars and name tags, bump into each other, and send quick messages with keys 1 to 4.

Without Supabase keys the game still works, in offline mode.

## Controls

| Key | Action |
| --- | --- |
| WASD / arrows | Walk and drive |
| E | Get in or out of a car |
| Space | Punch, shoot, handbrake |
| Shift | Run |
| R (hold) | Rewind time |
| T (hold) | Bullet time |
| V | Switch camera |
| N | Change radio station |
| H | Horn |
| Q | Switch fists and pistol |
| 1-4 | Send a quick message to other players |
| P | Pause and see the leaderboard |

On phones, the game shows an on-screen stick and buttons.

## Set up Supabase (about 5 minutes)

1. Create a free project at [supabase.com](https://supabase.com).
2. **Create the database table:** open **SQL Editor**, paste in all of [`supabase/schema.sql`](supabase/schema.sql), and click **Run**.
3. **Turn on guest logins:** go to **Authentication > Sign In / Providers** and switch on **Allow anonymous sign-ins**. Players don't need an email address. Each browser becomes its own guest player.
4. **Copy your keys:** go to **Project Settings > API**. Copy the **Project URL** and the **anon** (or **publishable**) key into [`config.js`](config.js).
   - Only use the public anon/publishable key.
   - Never use the `service_role` or secret key.
5. Commit and push. GitHub Pages updates within a minute or two.

## Put it online with GitHub Pages

1. Push this folder to a GitHub repository.
2. In the repository, go to **Settings > Pages**.
3. Under **Source**, choose **Deploy from a branch**, then pick `main` and `/ (root)`.
4. Your game will be live at `https://<your-username>.github.io/<repo-name>/`.

## Files

- `index.html`: the whole game. It uses Three.js for the 3D graphics and supabase-js for the online features, both loaded from public CDNs.
- `config.js`: your Supabase project URL and public key.
- `supabase/schema.sql`: sets up the database table and its security rules.

## Good to know

- The anon key is designed to be public. Row Level Security makes sure each player can only change their own save.
- This is a game for friends, so cash is saved from the player's browser. A determined player could edit their own score. The database caps values (for example, cash tops out at $100,000,000), so nobody can break the leaderboard.
- The Supabase free tier is plenty for a group of friends playing together.
