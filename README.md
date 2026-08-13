# Make a Minecraft Forge server

This folder creates a Minecraft Java **1.20.1 Forge** server.

## Before you start

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/).
2. Open Docker Desktop and wait until it says it is running.
3. Download or clone this repository.
4. Open the folder in PowerShell:

   ```powershell
   cd path\to\mc-server-REPO_1242dsf1saghj31
   ```

   Replace `path\to\mc-server-REPO_1242dsf1saghj31` with the real folder path.

   You can change the name of the file, just keep the new file in mind, you can easily copy the path by right clicking the file and selecting 'Copy as Path'

## Start the server

1. Run:

   ```powershell
   docker compose up -d
   ```

2. Watch it start:

   ```powershell
   docker compose logs -f minecraft
   ```

3. Wait until you see `Done` in the logs. The first start can take several minutes.
4. Close the log view with `Ctrl+C`.
5. Open Minecraft Java Edition with **version 1.20.1** and the matching Forge version.
6. Click **Multiplayer → Add Server**.
7. Enter this server address if you are playing on the same PC:

   ```text
   localhost:25565
   ```

## Let friends join from anywhere

Pick one method.

### Easy method: Playit (no router setup)

1. Make a free account at [playit.gg](https://playit.gg).
2. Create a new **agent** and copy its secret key.
3. In this folder, make a new file called `.env`.
4. Put this in `.env`, replacing the text after `=` with your Playit secret key:

   ```env
   PLAYIT_SECRET_KEY=put-your-secret-key-here
   ```

5. In Playit, create a **Minecraft Java** tunnel for your agent.
6. Set the tunnel's local address to `127.0.0.1` and its local port to `25565`.
7. Start the server and tunnel:

   ```powershell
   docker compose --profile tunnel up -d
   ```

8. Copy the public address shown by Playit and send it to your friends.

### Router method: use your public IP

1. Open your router settings.
2. Add a port-forwarding rule for **TCP port 25565** to this PC's local IP address, also on port `25565`.
3. Allow TCP port `25565` through Windows Firewall.
4. Find your public IP address and send friends:

   ```text
   YOUR-PUBLIC-IP:25565
   ```

If this does not work, your internet provider may use CGNAT. Use the Playit method instead.

## Add mods

1. Stop the server:

   ```powershell
   docker compose down
   ```

2. Put server mods in this folder:

   ```text
   data\mods
   ```

   The folder appears after the server has started once. Create it yourself if it does not exist.

3. Only use mods that say they work with **Minecraft 1.20.1** and **Forge 47.4.10**.
4. Start the server again:

   ```powershell
   docker compose up -d
   ```

   If you use Playit, run `docker compose --profile tunnel up -d` instead.

5. Your friends must install the same required mods in their own Minecraft Forge `mods` folder before joining.

## Change the server picture and message

1. Make a 64 × 64 pixel PNG image.
2. Name it exactly `server-icon.png`.
3. Put it here:

   ```text
   data\server-icon.png
   ```

4. To change the message below the server name, add this to `.env`:

   ```env
   SERVER_MOTD=My Minecraft server
   ```

5. Restart the server:

   ```powershell
   docker compose up -d
   ```

   If you use Playit, run `docker compose --profile tunnel up -d` instead.

## Useful commands

```powershell
# See whether the server is running
docker compose ps

# See the server log
docker compose logs -f minecraft

# Stop the server safely
docker compose down
```

## Important

- Never upload or share `.env` or `data/`. They can contain private server data and Playit secrets.
- Back up the `data/` folder before adding or removing mods.
