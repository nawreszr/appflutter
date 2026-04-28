# 🔧 Dépannage et Solutions

## ❌ Erreurs et Solutions

### Docker

#### "Docker daemon is not running"
```bash
# Windows: Ouvrir Docker Desktop depuis le menu Démarrer
# Mac: Ouvrir Applications > Docker.app
# Linux: sudo systemctl start docker
```

#### "Cannot connect to Docker daemon"
```bash
# Linux - Ajouter utilisateur au groupe docker
sudo usermod -aG docker $USER
newgrp docker

# Relancer votre terminal
```

#### "Port 8080 already in use"
```bash
# Windows (PowerShell)
netstat -ano | findstr :8080
taskkill /PID <PID> /F

# Mac/Linux
lsof -i :8080
kill -9 <PID>

# Ou changer le port dans docker-compose.yml
ports:
  - "8081:8080"  # Maintenant sur 8081
```

#### "Database connection refused"
```bash
# Vérifier que PostgreSQL démarre
docker compose logs db

# Attendre le health check
# Réinitialiser
docker compose down -v
docker compose up --build
```

#### "Image build fails"
```bash
# Nettoyer les images
docker system prune -a

# Reconstruire
docker compose up --build --no-cache
```

---

### API Spring Boot

#### "Failed to bind to port 8080"
```properties
# Changer le port dans application.properties
server.port=9090

# Redéployer
docker compose up --build
```

#### "Table 'etudiants' not found"
- Le schéma n'a pas été créé
- Vérifier que `spring.jpa.hibernate.ddl-auto=create-drop` est configuré
- Vérifier les logs : `docker compose logs api | grep ERROR`

#### "PostgreSQL driver not found"
```xml
<!-- Ajouter au pom.xml -->
<dependency>
    <groupId>org.postgresql</groupId>
    <artifactId>postgresql</artifactId>
    <version>42.6.0</version>
</dependency>
```

#### "Hibernate dialect not found"
```properties
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
```

#### API responds with 500 error
```bash
# Vérifier les logs
docker compose logs api

# Vérifier la connexion BD
docker compose logs db
```

---

### Flutter

#### "Failed to connect to API"
**Vérifier ces points (dans cet ordre):**

1. **IP machine correcte?**
   ```bash
   # Windows PowerShell
   ipconfig /all
   
   # Mac/Linux
   ifconfig
   # Cherchez inet (pas 127.0.0.1 ni ::1)
   ```

2. **URL correctement formatée dans etudiant_service.dart?**
   ```dart
   static const String baseUrl = 'http://192.168.1.100:8080/api/etudiants';
   // Pas de http://localhost ❌
   ```

3. **API réellement en cours d'exécution?**
   ```bash
   curl http://localhost:8080/api/etudiants
   # Doit retourner un JSON
   ```

4. **Firewall bloque le port 8080?**
   - Windows: Ajouter exception firewall
   - Mac: System Preferences → Security & Privacy
   - Linux: `sudo ufw allow 8080`

5. **Sur émulateur Android?** Utilisez l'adresse spéciale
   ```dart
   static const String baseUrl = 'http://10.0.2.2:8080/api/etudiants';
   ```

#### "flutter: Command not found"
```bash
# Ajouter Flutter au PATH
# Windows: Ajouter flutter\bin au PATH dans Propriétés Système

# Mac/Linux: Ajouter au ~/.bashrc ou ~/.zshrc
export PATH="$PATH:/chemin/vers/flutter/bin"
source ~/.bashrc
```

#### "Gradle build failed"
```bash
# Nettoyer le cache Flutter
flutter clean

# Réinstaller dépendances
flutter pub get

# Essayer à nouveau
flutter run
```

#### "Package http not found"
```bash
cd mobile-app
flutter pub get
flutter pub upgrade http

# Vérifier pubspec.yaml a les dépendances
```

#### "Device not found"
```bash
# Lister appareils
flutter devices

# Lancer emulateur Android
emulator -list-avds
emulator -avd <nom_avd>

# Ou connecter téléphone via USB
# Activer debugging USB
```

#### "Hot reload doesn't work"
```bash
# Relancer l'app
flutter run

# Ou arrêter et relancer
# Ctrl+C -> flutter run
```

#### TextField ne met pas à jour l'UI
```dart
// Utiliser setState
setState(() {
    // Mettre à jour variable
});
```

---

### Basis

#### "Git: Command not found"
```bash
# Installer Git
# https://git-scm.com/download

# Vérifier l'installation
git --version
```

#### "Maven build fails"
```bash
# Nettoyer cache Maven
mvn clean

# Télécharger dépendances
mvn dependency:resolve

# Construire
mvn package
```

#### ".gitignore n'ignore pas les fichiers"
```bash
# Les fichiers déjà commités ne seront pas ignorés
# Supprimer du cache et recommitter

# Supprimer du cache sans supprimer le fichier
git rm --cached <fichier>

# Ou supprimer tous les fichiers du cache
git rm -r --cached .
git add .
git commit -m "Apply .gitignore"
```

---

## 📊 Vérification Checklist

Avant de signaler un problème, vérifiez :

- [ ] Docker est installé : `docker --version`
- [ ] Docker Compose est installé : `docker compose version`
- [ ] Java 17+ est installé : `java -version`
- [ ] Flutter est installé : `flutter --version`
- [ ] Vous êtes dans le bon répertoire
- [ ] Les fichiers n'ont pas été modifiés accidentellement
- [ ] Vous avez attendu que PostgreSQL démarre (~30 secondes)
- [ ] Les ports 8080 et 5432 ne sont pas en utilisation

---

## 🔍 Diagnostiquer les Problèmes

### Logs complètes

```bash
# Tous les services
docker compose logs -f

# API uniquement
docker compose logs -f api

# BD uniquement
docker compose logs -f db

# Dernières 100 lignes
docker compose logs --tail=100
```

### Inspecteur Conteneurs

```bash
# Lister conteneurs actifs
docker ps

# Voir historique conteneurs
docker ps -a

# Inspecter un conteneur
docker inspect <container_id>

# Accéder au terminal conteneur
docker exec -it <container_name> /bin/bash

# Pour PostgreSQL
docker exec -it postgres_db psql -U etudiants_user -d etudiants_db
```

### Commandes Diagnostic Utiles

```bash
# Teste connectivité réseau
docker exec spring_api curl http://db:5432

# Voir ressources utilisées
docker stats

# Voir adresse IP conteneur
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container_name>
```

---

## 🌐 Test manuelle de l'API

### Avec curl

```bash
# Lister tous les étudiants
curl -X GET http://localhost:8080/api/etudiants

# Lister 1 étudiant
curl -X GET http://localhost:8080/api/etudiants/1

# Créer un étudiant
curl -X POST http://localhost:8080/api/etudiants \
  -H "Content-Type: application/json" \
  -d '{"cin":"99999999","nom":"Test","dateNaissance":"2000-01-01"}'

# Mettre à jour
curl -X PUT http://localhost:8080/api/etudiants/1 \
  -H "Content-Type: application/json" \
  -d '{"cin":"99999999","nom":"Updated","dateNaissance":"2000-01-01"}'

# Supprimer
curl -X DELETE http://localhost:8080/api/etudiants/1
```

### Avec PowerShell

```powershell
# GET
$response = Invoke-WebRequest -Uri "http://localhost:8080/api/etudiants" -Method Get
$response.Content | ConvertFrom-Json

# POST
$body = @{
    cin = "99999999"
    nom = "Test"
    dateNaissance = "2000-01-01"
} | ConvertTo-Json

Invoke-WebRequest -Uri "http://localhost:8080/api/etudiants" `
    -Method Post `
    -ContentType "application/json" `
    -Body $body
```

---

## 🐛 Bugs Connus et Contournements

| Bug | Cause | Solution |
|-----|-------|----------|
| Données perdues après redémarrage | Volume Docker pas persistant | Vérifier `docker-compose.yml` a les volumes |
| Connexion API Flutter timeout | Réseau lent ou API non réactive | Augmenter timeout (par défaut 10s) |
| CIN dupliqué error | Données initiales réinsérées | Utiliser `ddl-auto=update` au lieu de `create-drop` |
| Flutter menu n'apparaît pas | Dépendances pas recompilées | `flutter clean && flutter pub get` |

---

## 📞 Obtenir de l'Aide

Si vous êtes bloqué :

1. **Vérifier ce fichier** (Troubleshooting.md)
2. **Lire les logs** : `docker compose logs`
3. **Consulter README.md** et INSTRUCTIONS.md
4. **Consulter DEVELOPMENT_GUIDE.md**
5. **Lire documentation officelle** :
   - Spring Boot: https://spring.io/guides/
   - Flutter: https://flutter.dev/docs
   - Docker: https://docs.docker.com/engine/

---

**Bonne chance ! 🍀**
