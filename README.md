# Minecraft Forge Server

A beginner-friendly Minecraft Java **1.20.1 Forge** server. Docker installs and runs everything; you do **not** need to download a server JAR or install Java.

## Start the server

1. Install and open [Docker Desktop](https://www.docker.com/products/docker-desktop/).
2. Open this folder in PowerShell.
3. Start the server:

   ```powershell
   docker compose up -d
   ```

4. Watch the startup log:

   ```powershell
   docker compose logs -f minecraft
   ```

5. Wait for `Done (...)!` before joining. Stop watching the log with `Ctrl+C`.
6. In Minecraft, use **Minecraft 1.20.1** with **Forge 47.4.20** and join:

   ```text
   localhost:25565
   ```

## Let friends join with Playit.gg

1. Make an account at [playit.gg](https://playit.gg).
2. Create a Playit agent:

   1. Open the [Playit Docker setup wizard](https://playit.gg/account/setup/wizard/new-account/docker/docker-name) and sign in if asked.
   2. Choose **Docker** as the agent type.
   3. Give the agent a name, such as `Minecraft Server`, and create it.
   4. Playit shows a Docker command containing `SECRET_KEY=...`. Copy only the value after `SECRET_KEY=`—not the quotes and not the rest of the command.

3. Create a file named `.env` next to `docker-compose.yaml`.
4. Put your secret in it. Do not use quotes:

   ```env
   PLAYIT_SECRET_KEY=paste-your-secret-here
   ```

   The Playit secret is a private password that connects this computer's Playit agent to your Playit.gg account and tunnels. Docker passes it as `SECRET_KEY`; keep it only in `.env` and never share or upload it. Playit can also store it in its local `playit.toml` configuration file.

5. Start Playit:

   ```powershell
   docker compose --profile tunnel up -d --force-recreate playit
   ```

6. Check that it connected:

   ```powershell
   docker compose --profile tunnel logs -f playit
   ```

   Look for `playit connected; tunnels loaded`, then press `Ctrl+C`.

7. On the Playit website, create a tunnel with these exact settings:

   ```text
   Tunnel type: Minecraft Java
   Local address: 127.0.0.1
   Local port: 25565
   Agent: your new Docker agent
   ```

8. Save it and make sure the tunnel says **Online**.
9. Copy the public address shown by Playit and give that exact address to friends.

### Playit timeout?

- Join locally first with `localhost:25565`. If that works, Minecraft is fine.
- In Playit, make sure the tunnel is **Online** and assigned to the same agent whose secret is in `.env`.
- Confirm its local address is `127.0.0.1` and port is `25565`.
- Use the newest public address displayed in Playit. Old Playit addresses stop working after a new tunnel is created.
- Restart the Playit agent after changing the secret:

  ```powershell
  docker compose --profile tunnel up -d --force-recreate playit
  ```

## Add mods

1. Stop the server:

   ```powershell
   docker compose down
   ```

2. Put server mod `.jar` files in the `mods` folder next to `docker-compose.yaml`.
3. Only use mods made for **Minecraft 1.20.1** and **Forge 47.4.20**.
4. Do not put client-only mods on the server.
5. Every player must install the same required mods in their own Minecraft `mods` folder.
6. Start the server again:

   ```powershell
   docker compose --profile tunnel up -d
   ```

## Allow TLauncher / offline players

By default, the server checks official Minecraft accounts. To allow TLauncher or other offline players, add this to `.env`:

```env
ONLINE_MODE=FALSE
```

Then recreate the Minecraft container:

```powershell
docker compose up -d --force-recreate minecraft
```

If you use Playit, keep it running with:

```powershell
docker compose --profile tunnel up -d
```

Warning: offline mode lets anyone choose any username, including an operator's name. Only use it with people you trust.

## Change server name, description, or picture

To change the description shown below the server name in Minecraft, add this to `.env`:

```env
SERVER_MOTD=Welcome to my Minecraft server!
```

To add a server picture:

1. Make a **64 x 64 pixel PNG** image.
2. Name it exactly `server-icon.png`.
3. Put it in the `server-files` folder.
4. Restart the server:

   ```powershell
   docker compose restart minecraft
   ```

## Change settings, whitelist, or bans

Start the server once first. Then edit files in `server-files`:

```text
server.properties       Game mode, difficulty, PvP, max players, and more
whitelist.json          Allowed players
ops.json                Server operators
banned-ips.json         Banned IP addresses
banned-players.json     Banned players
config                  Forge configuration
world\serverconfig      Forge settings for this world
```

After any change, restart Minecraft:

```powershell
docker compose restart minecraft
```

## Useful commands

```powershell
# Check status
docker compose ps

# Watch the Minecraft log
docker compose logs -f minecraft

# Stop safely
docker compose down
```

## Keep private

Never upload `.env`, `server-files`, or your world files to GitHub. They can contain your Playit secret and private server data.
