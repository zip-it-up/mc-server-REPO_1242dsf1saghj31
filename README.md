# Minecraft Forge server

Minecraft Java **1.20.1** with **Forge 47.4.10**, Docker, and an optional Playit public tunnel.

## Start

Install and start [Docker Desktop](https://www.docker.com/products/docker-desktop/), then run:

```powershell
docker compose up -d
docker compose logs -f minecraft
```

The first Forge startup can take several minutes. Join with `localhost:25565` on the host PC, or use the host PC's LAN IP from the same network.

## Let friends join

Choose one option:

### Public IP

Forward **TCP port 25565** in your router to this PC's LAN IP on port `25565`, then share:

```text
YOUR-PUBLIC-IP:25565
```

Also allow TCP port `25565` through Windows Firewall. If port forwarding does not work because of CGNAT, use Playit instead.

### Playit tunnel

1. Create a Playit agent and Minecraft Java tunnel. Set the tunnel target to `127.0.0.1:25565`.
2. Copy `.env.example` to `.env` and add the agent secret:

   ```env
   PLAYIT_SECRET_KEY=your-secret-key
   ```

3. Start the tunnel:

   ```powershell
   docker compose --profile tunnel up -d
   ```

Share the address shown in the Playit dashboard.

## Customize

- Add a 64×64 PNG named `server-icon.png` at `data/server-icon.png`, then restart the server.
- Set the message shown in the Minecraft server list by adding this to `.env`:

  ```env
  SERVER_MOTD=My awesome Forge server
  ```

- For a custom address like `play.example.com`, create a DNS `A` record pointing to your public IP. Keep Minecraft's `server-ip` setting empty.
- Put compatible Forge mods in `data/mods/`. Players need the same required client mods.

## Commands

```powershell
# See status
docker compose ps

# Follow logs
docker compose logs -f minecraft playit

# Stop safely
docker compose down
```
