# Build stage
FROM node:20-alpine AS builder
WORKDIR /app

# Copier package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances
RUN npm ci

# Copier le code source
COPY . .

# Générer les fichiers de configuration de Tailwind et PostCSS
RUN npm run build

# Production stage
FROM node:20-alpine

WORKDIR /app

# Copier les fichiers de build depuis le stage builder
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules

# Variables d'environnement
ENV NEXT_PUBLIC_API_URL=http://api-gateway:8080/api
ENV NODE_ENV=production

# Port
EXPOSE 3000

# Commande de démarrage
CMD ["npm", "start"]
