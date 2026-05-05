# Next.js Frontend - Gestion des Étudiants

Application web Next.js pour gérer les étudiants, notes et départements via l'API Gateway.

## Démarrage

```bash
# Installation des dépendances
npm install

# Développement (port 3000)
npm run dev

# Build pour production
npm run build

# Production
npm start
```

## Structure des pages

- `/` - Page d'accueil avec navigation
- `/etudiants` - Gestion complète des étudiants (CRUD)
- `/notes` - Gestion des notes/grades avec statistiques
- `/departements` - Vue et filtrage par département

## Architecture

- **Framework**: Next.js 14 (App Router)
- **UI**: Tailwind CSS + Responsive Design
- **HTTP Client**: Axios
- **État**: React Hooks

## Configuration

L'API est accessible via:
```
NEXT_PUBLIC_API_URL = http://localhost:8080/api
```

Lors du déploiement Docker:
```
NEXT_PUBLIC_API_URL = http://api-gateway:8080/api
```

## Fonctionnalités

✅ Affichage de la liste des étudiants
✅ Création d'étudiants avec formulaire
✅ Suppression d'étudiants
✅ Gestion des notes/grades
✅ Filtrage par département
✅ Interface responsive
✅ Gestion des erreurs

## Technologies

- Next.js 14
- React 18
- Tailwind CSS 3
- Axios
- PostCSS + Autoprefixer
