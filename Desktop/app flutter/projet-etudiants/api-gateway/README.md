# api-gateway

Ce dossier accueillera le projet Spring Cloud Gateway.

## Objectif

- Routes vers `etudiant-service` et `grading-service`
- Exposer un point unique `/api`
- Rediriger `GET /api/etudiants/**` vers `etudiant-service`
- Rediriger `GET /api/notes/**` vers `grading-service`
