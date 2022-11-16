# Corekeeper dedicated server image

## Prerequisites

1. Make sure to have port 27015 allowed in your firewall config - [Reference](https://help.steampowered.com/en/faqs/view/2EA8-4D75-DA21-31EB).
2. Create local directory for game data. We need to change ownership to specific ID so that the process inside container that runs as `steam` user (with ID 1000) can access this folder.

```bash
mkdir /var/corekeeper
chown 1000:1000 /var/corekeeper
```

## Run the container

Run it interactively:
```bash
docker run -v /var/corekeeper:/var/corekeeper --network host -it --rm corekeeper bash start.sh
```
Game ID should appear. It will pe persisted across restarts. The error "_XSERVTransmkdir: ERROR: euid != 0,directory /tmp/.X11-unix will not be created." can be ignored.

Interrupt with Ctrl+C. Then run it in background:
```bash
docker run -v /var/corekeeper:/var/corekeeper --network host -d corekeeper bash start.sh
```
Use printed Game ID to join the game :)

## Worlds

They are located in `/var/corekeeper/worlds/`. If you want to swap the worlds, stop the container, swap `0.world.gzip` file and start container again.