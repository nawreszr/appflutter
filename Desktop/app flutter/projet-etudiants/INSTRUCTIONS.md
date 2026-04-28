# 📋 Guide Complet de Démarrage

## ✅ Prérequis

Installez les éléments suivants avant de commencer :

### Windows
- **Docker Desktop** : https://www.docker.com/products/docker-desktop
- **Flutter SDK** : https://flutter.dev/docs/get-started/install/windows
- **Java 17+** (optionnel) : https://www.oracle.com/java/technologies/downloads/

### Mac / Linux
```bash
# Installer Homebrew (macOS)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Installer Docker
brew install docker docker-compose

# Installer Flutter
git clone https://github.com/flutter/flutter.git ~/flutter
export PATH="$PATH:$HOME/flutter/bin"
```

---

## 🚀 Démarrage Rapide (3 étapes)

### Étape 1️⃣ : Lancer l'API et la Base de Données

#### Sur Windows :
```bash
# Double-cliquez sur start.bat
OU
cd projet-etudiants
start.bat
```

#### Sur Mac/Linux :
```bash
cd projet-etudiants
chmod +x start.sh
./start.sh
```

**Attendez le message** : `Started EtudiantsApiApplication`

### Étape 2️⃣ : Récupérer l'IP de votre Machine

#### Windows (PowerShell) :
```powershell
ipconfig
# Cherchez "Adresse IPv4"
# Exemple: 192.168.1.100
```

#### Mac/Linux (Terminal) :
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
# Exemple: 192.168.1.100
```

### Étape 3️⃣ : Configurer et Lancer l'App Mobile

```bash
# Accédez au dossier mobile
cd projet-etudiants/mobile-app

# Ouvrir le fichier d'édition
# Windows: start lib/services/etudiant_service.dart
# Mac: open lib/services/etudiant_service.dart
# Linux: xdg-open lib/services/etudiant_service.dart
```

**Modifiez la ligne** :
```dart
static const String baseUrl = 'http://192.168.1.100:8080/api/etudiants';
// ☝️ Remplacez 192.168.1.100 par votre IP
```

Puis lancez :
```bash
# Sur périphérique Android connecté
flutter run

# Ou sur émulateur
flutter run
```

---

## 🧪 Tester l'API

### Avec curl (Terminal/PowerShell)

```bash
# Windows (PowerShell)
$response = Invoke-WebRequest http://localhost:8080/api/etudiants
$response.Content

# Mac/Linux (Bash)
curl http://localhost:8080/api/etudiants | json_pp
```

### Avec Postman

1. Ouvrir **Postman**
2. Cliquer sur **Import**
3. Sélectionner le fichier `API_Etudiants.postman_collection.json`
4. **Envoyer les requêtes** 

### Avec le navigateur

Ouvrir : http://localhost:8080/api/etudiants

---

## 📱 État de Développement

| Composant | Status | Instructions |
|-----------|--------|-----|
| API REST | ✅ Complète | `docker compose up` |
| PostgreSQL | ✅ Configurée | Automatique via Docker |
| Flutter App | ✅ Complète | Modifier IP + `flutter run` |
| Docker | ✅ Prêt | Dans `docker-compose.yml` |

---

## 🛑 Arrêter les Services

### Arrêter l'API uniquement
```bash
docker compose stop
```

### Arrêter complètement (y compris les données)
```bash
docker compose down
```

### Arrêter et supprimer les données
```bash
docker compose down -v
```

---

## 🐛 Dépannage

### ❌ "Docker not found"
```bash
# Réinstaller Docker Desktop
https://www.docker.com/products/docker-desktop
```

### ❌ "Port 8080 already in use"
```bash
# Trouver le processus utilisant le port
# Windows (PowerShell)
netstat -ano | findstr :8080
taskkill /PID <PID> /F

# Mac/Linux
lsof -i :8080
kill -9 <PID>
```

### ❌ L'app Flutter ne se connecte pas

1. **Vérifiez l'IP** dans `etudiant_service.dart`
2. **Sur l'émulateur Android** :
   ```dart
   static const String baseUrl = 'http://10.0.2.2:8080/api/etudiants';
   ```
3. **Vérifiez le Firewall** - Ouvrir le port 8080

### ❌ PostgreSQL ne démarre pas

```bash
# Nettoyer et recommencer
docker compose down -v
docker compose up --build
```

---

## 📊 Architecture du Projet

```
projet-etudiants/
├── api-spring-boot/           # Backend
│   ├── src/main/java/
│   │   └── com/etudiants/api/
│   │       ├── entity/        # Modèles de données
│   │       ├── repository/    # Accès aux données
│   │       ├── service/       # Logique métier
│   │       └── controller/    # Endpoints REST
│   ├── pom.xml               # Dépendances Maven
│   └── Dockerfile            # Containerisation
│
├── mobile-app/                # Frontend Flutter
│   ├── lib/
│   │   ├── models/           # Modèles Dart
│   │   ├── services/         # Appels API HTTP
│   │   ├── screens/          # Interfaces utilisateur
│   │   └── main.dart         # Point d'entrée
│   └── pubspec.yaml          # Dépendances Flutter
│
├── docker-compose.yml        # Orchestration services
└── README.md                 # Documentation
```

---

## 🔗 Endpoints API

| Méthode | URL | Description |
|---------|-----|-----|
| **GET** | `/api/etudiants` | Liste tous les étudiants |
| **GET** | `/api/etudiants/{id}` | Récupère 1 étudiant |
| **POST** | `/api/etudiants` | Crée un étudiant |
| **PUT** | `/api/etudiants/{id}` | Modifie un étudiant |
| **DELETE** | `/api/etudiants/{id}` | Supprime un étudiant |

### Exemple JSON (Étudiant)

```json
{
  "id": 1,
  "cin": "12345678",
  "nom": "Ahmed Bennaceur",
  "dateNaissance": "2002-05-15"
}
```

---

## 💾 Données Initiales

L'API vient avec 7 étudiants chargés automatiquement :

```
1. Ahmed Bennaceur (CIN: 12345678)
2. Fatima Mansouri (CIN: 23456789)
3. Mohamed Karim (CIN: 34567890)
4. Leila Ben Salah (CIN: 45678901)
5. Youssef Hamza (CIN: 56789012)
6. Amira Dkhili (CIN: 67890123)
7. Ali Bouslama (CIN: 78901234)
```

---

## 📚 Ressources

- **Spring Boot** : https://spring.io/projects/spring-boot
- **Flutter** : https://flutter.dev/docs
- **PostgreSQL** : https://www.postgresql.org/docs/
- **Docker** : https://docs.docker.com/
- **REST API** : https://restfulapi.net/

---

## ✉️ Support

Pour toute question ou problème, consultez le README.md principal.

**Bonne chance ! 🎯**
