# 🚀 Démarrage Rapide - Partie 4

Projet entièrement complété et prêt à l'emploi !

## ⚡ 3 étapes pour démarrer

### Étape 1: Vérifier les prérequis

```bash
# Windows
verify.bat

# Mac/Linux
chmod +x verify.sh
./verify.sh
```

Prérequis nécessaires:
- ✅ Docker & Docker Compose
- ✅ Java 17+
- ✅ Maven 3.9+
- ✅ Node.js 20+

### Étape 2: Démarrer tous les services

```bash
cd projet-etudiants
docker-compose up --build
```

Cela va:
1. Builder toutes les images Docker
2. Démarrer PostgreSQL
3. Démarrer Eureka Server
4. Démarrer API Spring Boot
5. Démarrer Grading Service
6. Démarrer API Gateway
7. Démarrer Frontend Next.js

⏳ Attendez 30-60 secondes pour que tout démarre

### Étape 3: Accéder à l'application

| Service | URL |
|---------|-----|
| 🌐 Frontend | http://localhost:3000 |
| 🔌 API Gateway | http://localhost:8080 |
| 📡 Eureka | http://localhost:8761 |

## ✅ Vérification rapide

```bash
# API - Lister les étudiants
curl http://localhost:8080/api/etudiants

# API - Lister les notes
curl http://localhost:8080/api/notes

# Frontend
open http://localhost:3000
```

## 📱 Tester le Frontend

1. Ouvrir http://localhost:3000
2. Cliquer sur "Étudiants"
3. Voir la liste des 7 étudiants de test
4. Ajouter/Modifier/Supprimer des étudiants
5. Consulter les notes par département

## 🛑 Arrêter les services

```bash
# Dans le même terminal, appuyez sur Ctrl+C
# Ou dans un autre terminal:
docker-compose down

# Supprimer aussi les volumes
docker-compose down -v
```

## 🔧 Dépannage

### Erreur: Port déjà utilisé

```bash
# Trouver le service
lsof -i :3000      # Frontend
lsof -i :8080      # API Gateway
lsof -i :5432      # PostgreSQL

# Ou utiliser docker-compose avec un port différent
# Modifier les ports dans docker-compose.yml
```

### Erreur: Docker pas disponible

```bash
# Vérifier que Docker est en cours d'exécution
docker ps

# Redémarrer Docker Desktop (Windows/Mac)
```

### Erreur: Base de données non prête

```bash
# Attendre 10-15 secondes supplémentaires
# Les données se chargent lors du premier démarrage
```

## 📊 Architecture

```
┌─────────────────────────────────────────────────┐
│              Frontend Next.js                    │
│         (http://localhost:3000)                  │
└────────────────┬────────────────────────────────┘
                 │
┌────────────────▼────────────────────────────────┐
│            API Gateway                          │
│         (http://localhost:8080)                 │
├─────────────────────────────────────────────────┤
│   Service Discovery (Eureka - 8761)             │
└────────────────┬────────────────────────────────┘
         ┌───────┼───────┐
         │       │       │
    ┌────▼──┐ ┌──▼───┐ ┌──▼─────────┐
    │Etud.  │ │Grad. │ │PostgreSQL  │
    │Service│ │Service│ │(5432)      │
    │(8081) │ │(8082) │ └────────────┘
    └───────┘ └──────┘
```

## 📚 Documentation

- **[PARTIE4.md](./PARTIE4.md)** - Documentation complète
- **[INSTRUCTIONS.md](./INSTRUCTIONS.md)** - Guide détaillé
- **[frontend/README.md](./frontend/README.md)** - Frontend spécifique
- **[TROUBLESHOOTING.md](./TROUBLESHOOTING.md)** - Dépannage

## 🎯 Ce qui fonctionne maintenant

✅ **Backend**
- CRUD Étudiants (7 de test)
- CRUD Notes (21 de test)
- Découverte de services (Eureka)
- Gateway unique (API Gateway)
- Base de données persistante

✅ **Frontend**
- Page Accueil
- Gestion Étudiants (CRUD)
- Gestion Notes
- Filtrage Départements
- Design responsive

✅ **Infrastructure**
- Docker Compose
- GitHub Actions
- CI/CD pipelines
- Documentation complète

## 🚀 Prochaines étapes

1. **Git**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: Projet Partie 4"
   git branch -M main
   ```

2. **GitHub**
   - Créer un dépôt
   - Pousser le code
   - Configurer les secrets

3. **Production**
   - Utiliser GitHub Actions
   - Déployer sur cloud
   - Configurer monitoring

## 💡 Tips

- Utilisez `docker-compose logs -f` pour voir les logs en temps réel
- Utilisez `docker-compose restart service-name` pour redémarrer un service
- Les données sont persistantes dans les volumes Docker
- Le frontend est hot-reloadable en mode développement

---

**Vous êtes prêt! 🎉 Lancez le projet avec `docker-compose up --build`**
