# Partie 3 - Architecture Microservices

## Objectifs

- Ajouter un second micro service `grading-service` pour la gestion des notes
- Ajouter un serveur de découverte `eureka-server`
- Ajouter un point d'entrée unique `api-gateway`
- Mettre à jour l'application mobile pour sélectionner un département
- Créer un frontend Next.js dans `frontend/`
- Orchestrer le tout avec `docker-compose.yml`

## Tâches prioritaires

1. Créer la branche `version-3` à partir de `version-2`.
2. Mettre en place les templates GitHub et la convention de revue.
3. Créer `grading-service` avec les couches `entity`, `repository`, `service`, `controller`.
4. Créer `eureka-server` et configurer `@EnableEurekaServer`.
5. Ajouter `spring-cloud-starter-netflix-eureka-client` dans `api-spring-boot` et `grading-service`.
6. Créer `api-gateway` avec Spring Cloud Gateway et définir les routes :
   - `/api/etudiants/**` vers `etudiant-service`
   - `/api/notes/**` vers `grading-service`
7. Mettre à jour le backend existant pour exposer un endpoint `/api/departements`.
8. Mettre à jour `mobile-app` pour récupérer les départements et filtrer la liste.
9. Créer `frontend/` en Next.js pour gérer étudiants et départements.
10. Mettre à jour `docker-compose.yml` pour inclure tous les services.

## Pistes de développement

- Utiliser `FeignClient` dans `grading-service` pour valider l'existence d'un étudiant.
- Ne pas lier `Note` à `Etudiant` par FK JPA directe ; juste stocker `studentId`.
- Exposer Swagger / OpenAPI dans chaque microservice pour documentation.
- Charger les données de test dans PostgreSQL via `data.sql`.

## Structure cible du dépôt

```
projet-etudiants/
├── api-spring-boot/
├── grading-service/
├── eureka-server/
├── api-gateway/
├── frontend/
├── mobile-app/
├── .github/
└── docker-compose.yml
```

## Notes

- `api-spring-boot` deviendra `etudiant-service` conceptuellement.
- `grading-service` doit vérifier l'existence d'un étudiant via Feign au moment de la création d'une note.
- Tous les clients externes appellent l'API Gateway, pas les services métiers directement.
