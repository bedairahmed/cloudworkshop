# Docker Samples

This folder contains sample Dockerfiles and Docker Compose configurations for learning and reference.

## Contents

```
docker/
├── simple/
│   └── Dockerfile              # Beginner-friendly Dockerfile
├── node-app/
│   └── Dockerfile              # Multi-stage Node.js Dockerfile
├── python-app/
│   ├── Dockerfile              # Multi-stage Python Dockerfile
│   └── requirements.txt        # Python dependencies
├── docker-compose.simple.yml   # Simple app + database
├── docker-compose.fullstack.yml # Full stack with all services
├── docker-compose.yml          # Complete example
├── docker-compose.wordpress.yml # WordPress setup
└── .dockerignore               # Files to exclude from builds
```

---

## Quick Start

### Build and Run Single Container

```bash
# Build image
docker build -t myapp:1.0 .

# Run container
docker run -p 3000:3000 myapp:1.0

# Run in background
docker run -d -p 3000:3000 --name myapp myapp:1.0

# View logs
docker logs -f myapp

# Stop and remove
docker stop myapp
docker rm myapp
```

### Docker Compose

```bash
# Start services
docker compose up -d

# Start specific file
docker compose -f docker-compose.simple.yml up -d

# View logs
docker compose logs -f

# Stop services
docker compose down

# Stop and remove volumes
docker compose down -v
```

---

## Dockerfile Examples

### Simple (Beginner)

```dockerfile
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

### Multi-Stage (Production)

```dockerfile
# Build stage
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Production stage
FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY package*.json ./
RUN npm ci --only=production
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

---

## Docker Compose Examples

### Simple (App + Database)

```yaml
version: '3.8'
services:
  app:
    build: .
    ports:
      - "3000:3000"
    depends_on:
      - db
  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: secret
    volumes:
      - db-data:/var/lib/mysql
volumes:
  db-data:
```

### With Environment File

Create `.env` file:
```
DB_PASSWORD=secret
API_KEY=mykey
```

Reference in compose:
```yaml
services:
  app:
    environment:
      - DB_PASSWORD=${DB_PASSWORD}
      - API_KEY=${API_KEY}
```

---

## Common Commands

| Command | Description |
|---------|-------------|
| `docker build -t name .` | Build image |
| `docker run -p 3000:3000 name` | Run container |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers |
| `docker logs -f name` | Follow logs |
| `docker exec -it name bash` | Shell into container |
| `docker stop name` | Stop container |
| `docker rm name` | Remove container |
| `docker images` | List images |
| `docker rmi name` | Remove image |
| `docker compose up -d` | Start services |
| `docker compose down` | Stop services |
| `docker compose logs -f` | View logs |

---

## Best Practices

1. **Use multi-stage builds** - Smaller production images
2. **Use .dockerignore** - Exclude unnecessary files
3. **Run as non-root user** - Better security
4. **Use specific image tags** - Not `latest`
5. **Order commands for caching** - Copy package.json before source
6. **Use health checks** - Monitor container health
7. **Don't store secrets in images** - Use environment variables

---

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [Dockerfile Reference](https://docs.docker.com/reference/dockerfile/)
- [Compose File Reference](https://docs.docker.com/compose/compose-file/)