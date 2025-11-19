# ---- Build Stage ----
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install

# ---- Production Stage ----
FROM node:20-alpine
WORKDIR /app
COPY --from=build /app/node_modules ./node_modules
COPY package*.json ./
COPY app.js ./
EXPOSE 8080
CMD ["npm", "start"]