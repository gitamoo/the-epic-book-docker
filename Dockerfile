# STAGE 1: Builder
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# STAGE 2: Runtime
FROM node:18-alpine
WORKDIR /app
# Copy dependencies and the rest of the app
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app .

# Per the guide, we'll aim for port 8080
EXPOSE 8080
CMD ["node", "server.js"]
