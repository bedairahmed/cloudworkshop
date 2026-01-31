# Docker Cheatsheet

## What is Docker?

Docker is a platform for developing, shipping, and running applications in containers. Containers package an application with all its dependencies, ensuring it runs consistently across different environments. Docker revolutionized how we build and deploy applications.

---

## Why Use Docker?

- **Consistency** - "Works on my machine" becomes "works everywhere"
- **Isolation** - Applications run in isolated environments
- **Portability** - Run the same container on any system
- **Efficiency** - Containers share the OS kernel, lighter than VMs
- **Scalability** - Easy to scale with orchestration tools
- **DevOps** - Essential for modern CI/CD pipelines

---

## Key Concepts

| Concept | Description |
|---------|-------------|
| **Image** | Blueprint/template for creating containers |
| **Container** | Running instance of an image |
| **Dockerfile** | Script to build a Docker image |
| **Registry** | Storage for Docker images (Docker Hub, ACR, GCR) |
| **Volume** | Persistent storage for containers |
| **Network** | Communication between containers |
| **Compose** | Tool for multi-container applications |

---

## Installation

### Windows

```powershell
# Download Docker Desktop from
# https://www.docker.com/products/docker-desktop

# Or using winget
winget install Docker.DockerDesktop
```

### Mac

```bash
# Download Docker Desktop from
# https://www.docker.com/products/docker-desktop

# Or using Homebrew
brew install --cask docker
```

### Linux (Ubuntu/Debian)

```bash
# Remove old versions
sudo apt-get remove docker docker-engine docker.io containerd runc

# Install prerequisites
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add user to docker group (avoid sudo)
sudo usermod -aG docker $USER
newgrp docker
```

### Verify Installation

```bash
docker --version
docker run hello-world
```

---

## Images

### Pull & List Images

```bash
# Pull an image from Docker Hub
docker pull nginx
docker pull nginx:latest
docker pull nginx:1.25

# List local images
docker images
docker image ls

# Search Docker Hub
docker search nginx

# Remove an image
docker rmi nginx
docker image rm nginx

# Remove all unused images
docker image prune

# Remove all images
docker rmi $(docker images -q)
```

### Build Images

```bash
# Build from Dockerfile in current directory
docker build -t myapp:1.0 .

# Build with specific Dockerfile
docker build -t myapp:1.0 -f Dockerfile.prod .

# Build with build arguments
docker build -t myapp:1.0 --build-arg VERSION=1.0 .

# Build without cache
docker build -t myapp:1.0 --no-cache .

# Tag an image
docker tag myapp:1.0 myregistry/myapp:1.0

# Push to registry
docker push myregistry/myapp:1.0
```

---

## Containers

### Run Containers

```bash
# Run a container
docker run nginx

# Run in detached mode (background)
docker run -d nginx

# Run with a name
docker run -d --name my-nginx nginx

# Run with port mapping
docker run -d -p 8080:80 nginx        # host:container

# Run with environment variables
docker run -d -e MYSQL_ROOT_PASSWORD=secret mysql

# Run with volume mount
docker run -d -v /host/path:/container/path nginx
docker run -d -v myvolume:/data nginx

# Run interactively
docker run -it ubuntu bash

# Run and remove after exit
docker run --rm nginx

# Run with resource limits
docker run -d --memory=512m --cpus=1 nginx

# Run with restart policy
docker run -d --restart=always nginx
```

### Manage Containers

```bash
# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# Stop a container
docker stop my-nginx
docker stop $(docker ps -q)          # Stop all

# Start a stopped container
docker start my-nginx

# Restart a container
docker restart my-nginx

# Remove a container
docker rm my-nginx
docker rm -f my-nginx                 # Force remove running

# Remove all stopped containers
docker container prune

# Remove all containers
docker rm -f $(docker ps -aq)
```

### Container Interaction

```bash
# View container logs
docker logs my-nginx
docker logs -f my-nginx              # Follow logs
docker logs --tail 100 my-nginx      # Last 100 lines

# Execute command in running container
docker exec my-nginx ls /etc/nginx
docker exec -it my-nginx bash        # Interactive shell

# Copy files to/from container
docker cp file.txt my-nginx:/path/
docker cp my-nginx:/path/file.txt ./

# Inspect container details
docker inspect my-nginx

# View container stats
docker stats
docker stats my-nginx

# View container processes
docker top my-nginx
```

---

## Dockerfile

### Basic Structure

```dockerfile
# Base image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application code
COPY . .

# Expose port
EXPOSE 3000

# Set environment variable
ENV NODE_ENV=production

# Run command
CMD ["node", "server.js"]
```

### Common Instructions

```dockerfile
# FROM - Base image
FROM ubuntu:22.04
FROM python:3.11-slim

# WORKDIR - Set working directory
WORKDIR /app

# COPY - Copy files from host
COPY . .
COPY package.json ./

# ADD - Copy files (supports URLs and tar extraction)
ADD https://example.com/file.tar.gz /tmp/

# RUN - Execute commands during build
RUN apt-get update && apt-get install -y curl
RUN pip install -r requirements.txt

# ENV - Set environment variables
ENV APP_HOME=/app
ENV PORT=8080

# ARG - Build-time variables
ARG VERSION=1.0

# EXPOSE - Document ports
EXPOSE 80 443

# VOLUME - Create mount point
VOLUME /data

# USER - Set user
USER appuser

# CMD - Default command (can be overridden)
CMD ["python", "app.py"]

# ENTRYPOINT - Main command (not easily overridden)
ENTRYPOINT ["python"]
CMD ["app.py"]
```

### Multi-Stage Build

```dockerfile
# Build stage
FROM node:20 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

---

## Volumes

```bash
# Create a volume
docker volume create myvolume

# List volumes
docker volume ls

# Inspect a volume
docker volume inspect myvolume

# Remove a volume
docker volume rm myvolume

# Remove unused volumes
docker volume prune

# Use volume in container
docker run -d -v myvolume:/data nginx

# Bind mount (host directory)
docker run -d -v /host/path:/container/path nginx
docker run -d -v $(pwd):/app nginx
```

---

## Networks

```bash
# List networks
docker network ls

# Create a network
docker network create mynetwork

# Create bridge network with subnet
docker network create --driver bridge --subnet 172.20.0.0/16 mynetwork

# Run container on network
docker run -d --network mynetwork --name app1 nginx

# Connect container to network
docker network connect mynetwork my-container

# Disconnect from network
docker network disconnect mynetwork my-container

# Inspect network
docker network inspect mynetwork

# Remove network
docker network rm mynetwork
```

---

## Docker Compose

### docker-compose.yml Example

```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - DB_HOST=db
    depends_on:
      - db
    volumes:
      - ./app:/app
    networks:
      - app-network

  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: secret
      MYSQL_DATABASE: myapp
    volumes:
      - db-data:/var/lib/mysql
    networks:
      - app-network

volumes:
  db-data:

networks:
  app-network:
```

### Compose Commands

```bash
# Start services
docker compose up
docker compose up -d                  # Detached mode

# Build and start
docker compose up --build

# Stop services
docker compose down

# Stop and remove volumes
docker compose down -v

# View logs
docker compose logs
docker compose logs -f web           # Follow specific service

# List services
docker compose ps

# Execute command in service
docker compose exec web bash

# Scale services
docker compose up -d --scale web=3

# Pull images
docker compose pull

# Build images
docker compose build
```

---

## Registry Operations

```bash
# Login to Docker Hub
docker login

# Login to other registries
docker login myregistry.azurecr.io
docker login gcr.io

# Tag for registry
docker tag myapp:1.0 myregistry.azurecr.io/myapp:1.0

# Push to registry
docker push myregistry.azurecr.io/myapp:1.0

# Pull from registry
docker pull myregistry.azurecr.io/myapp:1.0

# Logout
docker logout
```

---

## Cleanup Commands

```bash
# Remove all stopped containers
docker container prune

# Remove all unused images
docker image prune
docker image prune -a                # Remove all unused (not just dangling)

# Remove all unused volumes
docker volume prune

# Remove all unused networks
docker network prune

# Remove everything unused
docker system prune
docker system prune -a --volumes     # Full cleanup

# View disk usage
docker system df
```

---

## Quick Reference

| Command | Description |
|---------|-------------|
| `docker pull <image>` | Download image |
| `docker build -t <n> .` | Build image |
| `docker run -d <image>` | Run container |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers |
| `docker stop <c>` | Stop container |
| `docker rm <c>` | Remove container |
| `docker logs <c>` | View logs |
| `docker exec -it <c> bash` | Shell into container |
| `docker compose up -d` | Start compose services |
| `docker compose down` | Stop compose services |

---

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [Dockerfile Reference](https://docs.docker.com/engine/reference/builder/)
- [Docker Compose Reference](https://docs.docker.com/compose/compose-file/)