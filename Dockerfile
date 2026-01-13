# ========================
# Stage 1: Builder
# ========================
FROM node:20-alpine AS builder
 
WORKDIR /app
 
# Copy package files
COPY package*.json ./
 
# Install dependencies
RUN npm install
 
# Copy source code
COPY . .
 
# Build step (simple example)
RUN mkdir -p dist && cp index.js dist/index.js
 
 
# ========================
# Stage 2: Production
# ========================
FROM node:20-alpine
 
WORKDIR /app
 
# Copy package files
COPY package*.json ./
 
# Install production dependencies
RUN npm install --production
 
# Copy built app from builder
COPY --from=builder /app/dist ./dist
 
# Expose port
EXPOSE 3000
 
# Run app
CMD ["node", "dist/index.js"]