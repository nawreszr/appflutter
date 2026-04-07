Mini Projet : API REST Spring Boot + Application Mobile
Description

Ce projet consiste à développer une API REST avec Spring Boot 4 permettant de gérer une liste d’étudiants, une base de données PostgreSQL exécutée avec Docker, et une application mobile (Flutter ou React Native) qui consomme l’API pour afficher la liste des étudiants.

Structure du projet
/projet-etudiants
│
├── api-spring-boot/
│   ├── src/
│   ├── Dockerfile
│   └── pom.xml
│
├── mobile-app/
│
└── docker-compose.yml
API REST
Endpoint

GET /api/etudiants → retourne la liste des étudiants

Attributs de l’entité Etudiant
id (Long)
cin (String)
nom (String)
dateNaissance (LocalDate)
Lancer le projet
docker compose up --build

API accessible sur :

http://localhost:8080/api/etudiants
Application mobile

L’application mobile consomme l’API et affiche :

CIN
Nom
Date de naissance

Commandes clés du projet Partie 2
Git
bash
git checkout -b version-2                    # Créer et basculer sur la branche
git add . && git commit -m "PROJ-XX: message" # Commiter les changements
git push -u origin version-2                 # Pusher sur GitHub
Docker
bash
docker build -t nawreszr/etudiant-service:1.0 .  # Construire l'image
docker push nawreszr/etudiant-service:1.0        # Publier sur Docker Hub
docker compose up --build                         # Lancer l'application
Kubernetes (K3S)
bash
kubectl apply -f k8s/postgres-deployment.yaml     # Déployer PostgreSQL
kubectl apply -f k8s/etudiant-deployment.yaml    # Déployer l'API
kubectl port-forward service/etudiant-service 8080:8080  # Accéder au service
Tests
bash
./mvnw test                                       # Exécuter les tests
./mvnw test -Dtest=CucumberRunnerTest            # Tester BDD Cucumber
Accès aux interfaces
bash
http://localhost:8080/api/etudiants              # API REST
http://localhost:8080/swagger-ui.html            # Documentation Swagger
http://localhost:8080/index.html                 # Interface web

