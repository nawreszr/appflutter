# Projet Étudiants - API REST + Mobile App

Un mini-projet complet composé d'une API REST Spring Boot 4, une base de données PostgreSQL via Docker, et une application mobile Flutter.

## Structure du Projet

```
projet-etudiants/
├── api-spring-boot/          # API REST Spring Boot 4
│   ├── src/
│   ├── pom.xml
│   └── Dockerfile
├── mobile-app/               # Application Flutter
│   ├── lib/
│   ├── pubspec.yaml
│   └── ...
├── docker-compose.yml        # Orchestration des services
└── README.md
```

## Prérequis

- **Docker & Docker Compose** ([Installer](https://docs.docker.com/get-docker/))
- **Java 17+** (pour développement local sans Docker)
- **Maven 3.9+** (pour builder l'API)
- **Flutter SDK** (pour l'app mobile)
- **Git**

## Partie 1 : API REST Spring Boot 4

### Description

- **Endpoint** : `GET /api/etudiants` - Retourne la liste de tous les étudiants
- **Modèle Etudiant** :
  - `id` (Long, auto-généré)
  - `cin` (String, unique)
  - `nom` (String)
  - `dateNaissance` (LocalDate)

### Endpoints disponibles

| Méthode | URL | Description |
|---------|-----|-------------|
| GET | `/api/etudiants` | Récupère tous les étudiants |
| GET | `/api/etudiants/{id}` | Récupère un étudiant par ID |
| POST | `/api/etudiants` | Crée un nouvel étudiant |
| PUT | `/api/etudiants/{id}` | Met à jour un étudiant |
| DELETE | `/api/etudiants/{id}` | Supprime un étudiant |

### Technologies utilisées

- Spring Boot 3.1.5
- Spring Data JPA
- PostgreSQL 15
- Lombok
- Maven

## Partie 2 : Exécution avec Docker

### Lancement complet (Recommandé)

```bash
# Depuis la racine du projet
docker compose up --build
```

### Accès aux services

- **API Spring Boot** : http://localhost:8080/api/etudiants
- **PostgreSQL** : localhost:5432
  - Username: `etudiants_user`
  - Password: `etudiants_password`
  - Database: `etudiants_db`

### Configuration Docker

**docker-compose.yml** définit :
- Service PostgreSQL avec données persistantes
- Service Spring Boot dépendant du service DB
- Réseau privé pour la communication inter-services
- Health checks

### Arrête des services

```bash
docker compose down

# Avec suppression des volumes
docker compose down -v
```

## Partie 3 : Application Mobile Flutter

### Configuration

**Important** : Modifiez l'URL de l'API dans `lib/services/etudiant_service.dart`

```dart
static const String baseUrl = 'http://<IP_MACHINE>:8080/api/etudiants';
```

Remplacez `<IP_MACHINE>` par l'adresse IP de votre machine locale (ex: `192.168.1.100`).

### Fonctionnalités

- Affiche la liste de tous les étudiants
- Affiche pour chaque étudiant :
  - CIN
  - Nom
  - Date de naissance (formatée: dd/MM/yyyy)
- Rafraîchissement via pull-to-refresh
- Gestion des erreurs avec retry
- Interface responsive

### Lancement de l'app Flutter

```bash
cd mobile-app

# Installer les dépendances
flutter pub get

# Lancer sur appareil connecté ou émulateur
flutter run

# Ou build APK
flutter build apk

# Ou build pour iOS
flutter build ios
```

### Technologies utilisées

- Flutter 3.0+
- Package `http` pour les requêtes HTTP
- Package `intl` pour le formatage des dates
- ListView.builder pour l'affichage optimisé

## Données Initiales

L'API est pré-chargée avec 7 étudiants via `data.sql` :

| CIN | Nom | Date Naissance |
|-----|-----|---|
| 12345678 | Ahmed Bennaceur | 2002-05-15 |
| 23456789 | Fatima Mansouri | 2001-08-22 |
| 34567890 | Mohamed Karim | 2003-02-10 |
| 45678901 | Leila Ben Salah | 2002-11-03 |
| 56789012 | Youssef Hamza | 2001-07-28 |
| 67890123 | Amira Dkhili | 2003-03-14 |
| 78901234 | Ali Bouslama | 2002-09-19 |

## Workflow Complet (Pas à Pas)

### 1. Cloner le projet (ou vérifier la structure)

```bash
cd projet-etudiants
```

### 2. Lancer les services Docker

```bash
# Construction et lancement
docker compose up --build

# Attendez que l'API soit prête : "Started EtudiantsApiApplication"
```

### 3. Tester l'API

```bash
# Via curl
curl http://localhost:8080/api/etudiants

# Via Postman
GET http://localhost:8080/api/etudiants
```

### 4. Configurer et lancer l'app mobile

```bash
cd mobile-app

# Mettre à jour l'IP de la machine dans lib/services/etudiant_service.dart
# Puis lancer
flutter run
```

## Troubleshooting

### L'API ne démarre pas

```bash
# Vérifiez les logs du conteneur
docker compose logs api

# Vérifiez que PostgreSQL soit prêt
docker compose logs db
```

### La connexion à l'API depuis Flutter échoue

- Vérifiez que l'IP dans `etudiant_service.dart` est correcte
- Vérifiez la conectivité réseau
- Sur émulateur Android, utilisez `10.0.2.2` à la place de `localhost`

### PostgreSQL n'accepte pas les connexions

```bash
# Réinitialiser les données
docker compose down -v
docker compose up --build
```

## Variables d'environnement

### Fichier `.env` (à créer à la racine)

```env
POSTGRES_DB=etudiants_db
POSTGRES_USER=etudiants_user
POSTGRES_PASSWORD=etudiants_password
SPRING_PORT=8080
```

## Développement Local (sans Docker)

### 1. Lancer PostgreSQL localement

```bash
# Via Docker seul
docker run --name postgres_dev \
  -e POSTGRES_DB=etudiants_db \
  -e POSTGRES_USER=etudiants_user \
  -e POSTGRES_PASSWORD=etudiants_password \
  -p 5432:5432 \
  postgres:15-alpine
```

### 2. Lancer l'API

```bash
cd api-spring-boot
mvn spring-boot:run
```

### 3. Modifier `application.properties` pour local

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/etudiants_db
```

## Workflow GitHub et Revue de Code

Pour la Partie 3, nous utilisons une branche dédiée `version-3` et des modèles GitHub :

- Créez la branche à partir de `version-2`
  ```bash
git checkout version-2
git checkout -b version-3
```
- Ne pas pousser directement sur `main` ou `version-3`
- Ouvrez toujours une issue ou un ticket Jira avant de commencer une fonctionnalité
- Utilisez les templates de GitHub :
  - `.github/ISSUE_TEMPLATE/bug_report.md`
  - `.github/ISSUE_TEMPLATE/feature_request.md`
  - `.github/pull_request_template.md`
- Revue attendue :
  - minimum 1 approbation avant merge
  - corriger tous les commentaires bloquants
  - commenter le lien du ticket Jira dans la PR
  - tester localement avant de soumettre

## Déploiement

### Cloud (Heroku, AWS, Google Cloud)

Utilisez le `Dockerfile` fourni pour containeriser l'API.

### GitHub Actions (CI/CD)

À implémenter pour :
- Tester l'API (unit tests)
- Builder l'image Docker
- Pousser vers un registre

## Ressources

- [Documentation Spring Boot](https://spring.io/projects/spring-boot)
- [Documentation PostgreSQL Docker](https://hub.docker.com/_/postgres)
- [Documentation Flutter](https://flutter.dev/docs)
- [API REST Best Practices](https://restfulapi.net/)

## Auteur

Projet académique - Formateur: Wahid Hamdi

## Licence

MIT
