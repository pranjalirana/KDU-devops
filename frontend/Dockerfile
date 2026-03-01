# ---- Build stage (Node.js) ----
FROM node:20-alpine AS build

WORKDIR /app

# Copy package files first (better caching)
COPY package.json package-lock.json ./

# Install dependencies
RUN npm ci

# Copy full app source (including public/config.template.js)
COPY . .

# Build React app (no build-time API URL needed now)
RUN npm run build

# ---- Production stage (Nginx) ----
FROM nginx:alpine

# Copy built React files to Nginx web directory
COPY --from=build /app/build /usr/share/nginx/html

# Copy runtime config template into Nginx web directory
# (Make sure you created: public/config.template.js)
COPY --from=build /app/public/config.template.js /usr/share/nginx/html/config.template.js

EXPOSE 80

# Generate config.js at container start using runtime env vars, then start Nginx
CMD ["/bin/sh", "-c", "envsubst < /usr/share/nginx/html/config.template.js > /usr/share/nginx/html/config.js && nginx -g 'daemon off;'"]