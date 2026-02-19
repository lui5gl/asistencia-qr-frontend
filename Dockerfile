# ─────────────────────────────────────────────
# Stage: development
# Expo / React Native – asistencia-qr-frontend
# ─────────────────────────────────────────────
FROM node:24.13.1-alpine AS development

# System dependencies required by some native modules
RUN apk add --no-cache git

WORKDIR /app

# Copy package manifests first to leverage Docker layer caching.
# Dependencies are only re-installed when package*.json changes.
COPY package*.json ./
RUN npm ci --prefer-offline

# Copy the rest of the source code
COPY . .

# Expo Metro bundler (JavaScript bundler for React Native / web)
EXPOSE 8081

# Expo DevTools
EXPOSE 19000

# Required for Metro to bind to all interfaces inside the container
ENV EXPO_DEVTOOLS_LISTEN_ADDRESS=0.0.0.0

# Start Expo in web mode so teammates can access it via browser
CMD ["npx", "expo", "start", "--web", "--port", "8081"]