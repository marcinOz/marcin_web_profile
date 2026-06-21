# Stage 1: Build the Vite React application
FROM node:22-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Serve the application using the custom server
FROM node:22-alpine
WORKDIR /app
COPY --from=builder /app/dist ./
COPY server.cjs ./
ENV PORT=3000
EXPOSE 3000
CMD ["node", "server.cjs"]
