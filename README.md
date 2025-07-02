# PlatON Node Docker Setup

This project provides a Dockerized setup for running a [PlatON]((https://platon.network/) node.

## Project Structure
- `docker-compose.yaml`: Docker Compose configuration for running the PlatON node container.
- `Dockerfile`: Builds the PlatON node image based on Ubuntu 22.04, installing required dependencies and the Platon binaries.
- `entrypoint.sh`: Entrypoint script to initialize and start the PlatON node.

## Prerequisites
- [Docker](https://docs.docker.com/get-docker/) (v20+ recommended)
- [Docker Compose](https://docs.docker.com/compose/install/) (v2+ recommended)

## Environment Variables
The following environment variables must be set before running the container:

- `VERSION`: The version of PlatON to download and run (e.g., `1.5.0`).
- `NAME`: The name for the container and data directory.
- `P2P_PORT`: The external port to map to the node's P2P port (16789).
- `RPC_PORT`: The external port to map to the node's RPC port (6789).
- `MONITOR_PORT`: The external port to map to the node's metrics port (6060).
- `BASEDIR`: The base directory on the host for persistent data (e.g., `/data`).

## Usage

### 1. Set Environment Variables
Export the required environment variables in your shell:

```sh
export VERSION=1.5.0
export NAME=explorare
export P2P_PORT=16789
export RPC_PORT=6789
export MONITOR_PORT=6060
export BASEDIR=/data
```

### 2. Build and Start the Node

```sh
docker-compose up --build -d
```

This will build the Docker image and start the PlatON node container in detached mode.

### 3. Data Persistence

The following directories will be created under `${BASEDIR}/${NAME}` on the host for persistent storage:
- `platon-node`: Node data
- `keystore`: Keystore files
- `validator`: Validator files

### 4. Stopping the Node

```sh
docker-compose down
```

## Exposed Ports
- **P2P:** `${P2P_PORT}` (UDP/TCP, mapped to 16789 in the container)
- **RPC:** `${RPC_PORT}` (TCP, mapped to 6789 in the container, localhost only)
- **Metrics:** `${MONITOR_PORT}` (TCP, mapped to 6060 in the container)

## Entrypoint Logic
- On first run, the entrypoint script initializes the node keys if not already present.
- The PlatON node is started with HTTP and metrics enabled, using the generated keys.

## References
- [PlatON Official Documentation](https://platon.network/)

---

For any issues or questions, please refer to the official PlatON documentation or open an issue in this repository. 
