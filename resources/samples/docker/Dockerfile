# Dockerfile - Simple Example (Beginner Friendly)
# File: Dockerfile.simple
#
# A simple, easy-to-understand Dockerfile
#
# Build:  docker build -t myapp .
# Run:    docker run -p 3000:3000 myapp

# 1. Start from a base image
FROM node:20-alpine

# 2. Set working directory
WORKDIR /app

# 3. Copy package.json first (for caching)
COPY package*.json ./

# 4. Install dependencies
RUN npm install

# 5. Copy all source code
COPY . .

# 6. Expose port
EXPOSE 3000

# 7. Command to run the app
CMD ["npm", "start"]