# 👨‍💻 Guide de Développement

Ce document explique la structure du code et comment étendre le projet.

---

## 📁 Structure Backend (Spring Boot)

### Package Structure

```
com.etudiants.api/
├── EtudiantsApiApplication    # Point d'entrée Spring Boot
├── entity/
│   └── Etudiant              # Modèle JPA @Entity
├── repository/
│   └── EtudiantRepository    # Interface JpaRepository
├── service/
│   └── EtudiantService       # Logique métier
└── controller/
    └── EtudiantController    # Endpoints REST
```

### Fichiers de Configuration

- **[application.properties](api-spring-boot/src/main/resources/application.properties)** : Configuration Spring Boot
  - URL PostgreSQL
  - Paramètres JPA/Hibernate
  - Niveau de log

- **[data.sql](api-spring-boot/src/main/resources/data.sql)** : Données initiales

### Dépendances Maven (pom.xml)

```xml
<!-- Spring Web REST -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>

<!-- JPA/Hibernate -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>

<!-- PostgreSQL -->
<dependency>
    <groupId>org.postgresql</groupId>
    <artifactId>postgresql</artifactId>
</dependency>

<!-- Lombok (annotations) -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
</dependency>
```

---

## 🔧 Ajouter Nouvelles Fonctionnalités Backend

### 1️⃣ Ajouter un Champ à l'Entité Étudiant

**Fichier** : [Etudiant.java](api-spring-boot/src/main/java/com/etudiants/api/entity/Etudiant.java)

```java
@Entity
@Table(name = "etudiants")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Etudiant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "cin", nullable = false, unique = true)
    private String cin;
    
    @Column(name = "nom", nullable = false)
    private String nom;
    
    @Column(name = "date_naissance")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate dateNaissance;
    
    // ✅ Ajouter ici
    @Column(name = "email")
    private String email;
    
    @Column(name = "telephone")
    private String telephone;
}
```

### 2️⃣ Ajouter un Endpoint Custom

**Fichier** : [EtudiantController.java](api-spring-boot/src/main/java/com/etudiants/api/controller/EtudiantController.java)

```java
@RestController
@RequestMapping("/api/etudiants")
public class EtudiantController {
    
    @Autowired
    private EtudiantService etudiantService;
    
    // ✅ Ajouter ici
    @GetMapping("/search")
    public ResponseEntity<Etudiant> searchByCin(@RequestParam String cin) {
        return ResponseEntity.ok(etudiantService.getEtudiantByCin(cin));
    }
    
    @GetMapping("/count")
    public ResponseEntity<Long> countEtudiants() {
        return ResponseEntity.ok(etudiantService.countEtudiants());
    }
}
```

### 3️⃣ Ajouter une Méthode Service

**Fichier** : [EtudiantService.java](api-spring-boot/src/main/java/com/etudiants/api/service/EtudiantService.java)

```java
@Service
public class EtudiantService {
    
    @Autowired
    private EtudiantRepository etudiantRepository;
    
    // ✅ Ajouter ici
    public long countEtudiants() {
        return etudiantRepository.count();
    }
    
    public List<Etudiant> searchByName(String nom) {
        return etudiantRepository.findByNomContainingIgnoreCase(nom);
    }
}
```

### 4️⃣ Ajouter une Requête Repository

**Fichier** : [EtudiantRepository.java](api-spring-boot/src/main/java/com/etudiants/api/repository/EtudiantRepository.java)

```java
@Repository
public interface EtudiantRepository extends JpaRepository<Etudiant, Long> {
    
    // Recherche existante
    Etudiant findByCin(String cin);
    
    // ✅ Ajouter ici
    List<Etudiant> findByNomContainingIgnoreCase(String nom);
    
    @Query("SELECT e FROM Etudiant e WHERE YEAR(e.dateNaissance) = ?1")
    List<Etudiant> findByYearOfBirth(int year);
}
```

---

## 📱 Structure Frontend (Flutter)

### Dossier Structure

```
lib/
├── main.dart                 # Point d'entrée
├── models/
│   └── etudiant.dart        # Classe de données (parseJSON)
├── services/
│   └── etudiant_service.dart # Requêtes HTTP
└── screens/
    └── etudiants_list_screen.dart  # UI principale
```

### Fichiers Clés

- **pubspec.yaml** : Dépendances du projet
- **main.dart** : Configuration MaterialApp
- **models/etudiant.dart** : Désérialisation JSON
- **services/etudiant_service.dart** : requêtes API
- **screens/etudiants_list_screen.dart** : Interface utilisateur

---

## 🔧 Ajouter Nouvelles Fonctionnalités Frontend

### 1️⃣ Ajouter une Fonction Service

**Fichier** : `lib/services/etudiant_service.dart`

```dart
class EtudiantService {
    static const String baseUrl = 'http://192.168.x.x:8080/api/etudiants';
    
    // ✅ Ajouter ici
    Future<int> countEtudiants() async {
        try {
            final response = await http.get(
                Uri.parse('$baseUrl/count'),
            ).timeout(const Duration(seconds: 10));
            
            if (response.statusCode == 200) {
                return int.parse(response.body);
            }
            throw Exception('Failed');
        } catch (e) {
            throw Exception('Error: $e');
        }
    }
    
    Future<List<Etudiant>> searchByName(String nom) async {
        // Implémenter similarement
    }
}
```

### 2️⃣ Ajouter un Écran

Créer **`lib/screens/search_screen.dart`** :

```dart
class SearchScreen extends StatefulWidget {
    const SearchScreen({Key? key}) : super(key: key);
    
    @override
    State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
    final EtudiantService service = EtudiantService();
    final TextEditingController searchController = TextEditingController();
    List<Etudiant> searchResults = [];
    
    void performSearch() {
        // Implémenter la recherche
    }
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('Rechercher')),
            body: Column(
                children: [
                    TextField(
                        controller: searchController,
                        onSubmitted: (value) => performSearch(),
                        decoration: const InputDecoration(hint: 'Cherchez...'),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: searchResults.length,
                            itemBuilder: (context, index) {
                                return ListTile(
                                    title: Text(searchResults[index].nom),
                                );
                            },
                        ),
                    ),
                ],
            ),
        );
    }
}
```

### 3️⃣ Ajouter un Widget Réutilisable

Créer **`lib/widgets/etudiant_card.dart`** :

```dart
class EtudiantCard extends StatelessWidget {
    final Etudiant etudiant;
    final VoidCallback onTap;
    
    const EtudiantCard({
        Key? key,
        required this.etudiant,
        required this.onTap,
    }) : super(key: key);
    
    @override
    Widget build(BuildContext context) {
        return GestureDetector(
            onTap: onTap,
            child: Card(
                child: ListTile(
                    title: Text(etudiant.nom),
                    subtitle: Text(etudiant.cin),
                ),
            ),
        );
    }
}
```

---

## 📦 Dépendances Flutter (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0           # Requêtes HTTP
  intl: ^0.19.0          # Formatage dates/nombres

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0  # Analyse de code
```

---

## 🐳 Configuration Docker

### Modifier Dockerfile

[Dockerfile](api-spring-boot/Dockerfile) utilise un build multi-étapes :

```dockerfile
# Stage 1: Build
FROM maven:3.9.4-eclipse-temurin-17 as builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
```

### Builder l'image manuellement

```bash
cd api-spring-boot
docker build -t etudiants-api:1.0 .
docker run -p 8080:8080 etudiants-api:1.0
```

---

## 🫗 Variables d'Environnement

Créer `.env` à la racine :

```env
POSTGRES_DB=etudiants_db
POSTGRES_USER=etudiants_user
POSTGRES_PASSWORD=etudiants_password
SPRING_PORT=8080
```

Puis dans `docker-compose.yml` :

```yaml
services:
  db:
    environment:
      POSTGRES_DB: ${POSTGRES_DB:-etudiants_db}
      POSTGRES_USER: ${POSTGRES_USER:-etudiants_user}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
```

---

## 🧪 Tests

### Tests Unitaires (Backend)

Créer `src/test/java/com/etudiants/api/service/EtudiantServiceTest.java` :

```java
@SpringBootTest
class EtudiantServiceTest {
    
    @MockBean
    private EtudiantRepository repository;
    
    @Autowired
    private EtudiantService service;
    
    @Test
    void testGetAllEtudiants() {
        // Arrange
        List<Etudiant> mockList = Arrays.asList(
            new Etudiant(1L, "12345", "Ahmed", LocalDate.now())
        );
        when(repository.findAll()).thenReturn(mockList);
        
        // Act
        List<Etudiant> result = service.getAllEtudiants();
        
        // Assert
        assertEquals(1, result.size());
    }
}
```

### Tests Flutter

Créer `test/etudiant_test.dart` :

```dart
void main() {
    group('Etudiant Model', () {
        test('fromJson should parse correctly', () {
            final json = {
                'id': 1,
                'cin': '12345678',
                'nom': 'Ahmed',
                'dateNaissance': '2002-05-15'
            };
            
            final etudiant = Etudiant.fromJson(json);
            
            expect(etudiant.id, 1);
            expect(etudiant.cin, '12345678');
        });
    });
}
```

---

## 🚀 Déploiement

### Déployer sur Heroku

```bash
# Créer app Heroku
heroku create mon-api-etudiants

# Ajouter PostgreSQL
heroku addons:create heroku-postgresql:hobby-dev

# Configurer variables
heroku config:set SPRING_JPA_HIBERNATE_DDL_AUTO=create-drop

# Déployer
git push heroku main
```

### Déployer l'app Flutter

```bash
# Build APK (Android)
flutter build apk --release

# Build iOS
flutter build ios --release

# Web
flutter build web --release
```

---

## 📊 Diagramme d'Architecture

```
┌─────────────────────────────────────────┐
│         Flutter Mobile App              │
│  (ListView → HTTP → EtudiantService)    │
└──────────────────┬──────────────────────┘
                   │
                   │ HTTP GET
                   │
┌──────────────────▼──────────────────────┐
│    Spring Boot API (Port 8080)          │
│  (Controller → Service → Repository)    │
└──────────────────┬──────────────────────┘
                   │
                   │ JDBC
                   │
┌──────────────────▼──────────────────────┐
│   PostgreSQL (Port 5432)                │
│   (Base de données)                     │
└─────────────────────────────────────────┘
```

---

## 📝 Checklist d'Extension

- [ ] Ajouter champ `email` à Etudiant
- [ ] Créer endpoint de recherche `/api/etudiants/search?nom=Ahmed`
- [ ] Implémenter pagination dans la liste Flutter
- [ ] Ajouter authentification JWT
- [ ] Créer tests unitaires complètes
- [ ] Implémenter mise en cache côté front
- [ ] Ajouter validation des formulaires
- [ ] Intégrer logging (SLF4J backend)
- [ ] Configurer Swagger/Spring Fox pour la doc API
- [ ] Déployer sur cloud (Heroku/AWS)

---

## 🤝 Contribution

Pour modifier le projet :

1. Créer une branche `git checkout -b feature/ma-fonctionnalite`
2. Committer les changements `git commit -m "Ajouter XXX"`
3. Pousser la branche `git push origin feature/ma-fonctionnalite`
4. Ouvrir une Pull Request

---

## 📞 Questions Fréquentes

**Q: Comment changer le port de l'API?**  
R: Modifiez `server.port=8080` dans `application.properties`

**Q: Comment utiliser une autre base de données?**  
R: Changez le driver JDBC et dépendances dans `pom.xml`

**Q: Comment compiler sans Docker?**  
R: : `mvn clean install` dans le dossier `api-spring-boot`

**Q: Comment importer le projet dans IDE?**  
R: Fichier → Ouvrir → Sélectionner `pom.xml`

---

**Enjoy coding! 🎯**
