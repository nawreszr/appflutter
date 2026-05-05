# 🚨 Critical Issues - Fix Required Before Phase 4

## Issue 1: Eureka Server Dockerfile - mvnw Not Found

**File**: `eureka-server/Dockerfile`  
**Severity**: 🔴 CRITICAL - Build will fail  
**Impact**: Service won't build in Docker

### Current Code (Lines 3):
```dockerfile
FROM eclipse-temurin:17-jdk-jammy AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN ./mvnw clean package -DskipTests  # ❌ mvnw doesn't exist
```

### Fix:
Replace line 5 with:
```dockerfile
RUN mvn clean package -DskipTests
```

**Note**: Maven (mvn) is available in the `eclipse-temurin:17-jdk-jammy` image.

---

## Issue 2: API Gateway Dockerfile - mvnw Not Found

**File**: `api-gateway/Dockerfile`  
**Severity**: 🔴 CRITICAL - Build will fail  
**Impact**: API Gateway service won't start, blocking all API requests

### Current Code (Line 5):
```dockerfile
RUN ./mvnw clean package -DskipTests  # ❌ mvnw doesn't exist
```

### Fix:
Same as Issue 1 - replace with:
```dockerfile
RUN mvn clean package -DskipTests
```

---

## Issue 3: Grading Service - Missing Database Configuration in Docker Compose

**File**: `docker-compose.yml` (Lines 56-70)  
**Severity**: 🔴 CRITICAL - Service fails to start  
**Impact**: Grading service crashes on startup, no database connection

### Current Code:
```yaml
grading-service:
    build:
      context: ./grading-service
      dockerfile: Dockerfile
    container_name: grading_service
    ports:
      - "8082:8082"
    environment:
      SPRING_APPLICATION_NAME: grading-service
      EUREKA_CLIENT_SERVICEURL_DEFAULTZONE: http://eureka-server:8761/eureka
    depends_on:
      - db
      - eureka-server
    networks:
      - etudiants_network
    restart: unless-stopped
```

### Missing Environment Variables:
The following lines must be added to the `environment` section:
```yaml
SPRING_DATASOURCE_URL: jdbc:postgresql://db:5432/etudiants_db
SPRING_DATASOURCE_USERNAME: etudiants_user
SPRING_DATASOURCE_PASSWORD: etudiants_password
SPRING_JPA_HIBERNATE_DDL_AUTO: create-drop
```

### Fixed Code:
```yaml
grading-service:
    build:
      context: ./grading-service
      dockerfile: Dockerfile
    container_name: grading_service
    ports:
      - "8082:8082"
    environment:
      SPRING_APPLICATION_NAME: grading-service
      SPRING_DATASOURCE_URL: jdbc:postgresql://db:5432/etudiants_db
      SPRING_DATASOURCE_USERNAME: etudiants_user
      SPRING_DATASOURCE_PASSWORD: etudiants_password
      SPRING_JPA_HIBERNATE_DDL_AUTO: create-drop
      EUREKA_CLIENT_SERVICEURL_DEFAULTZONE: http://eureka-server:8761/eureka
    depends_on:
      - db
      - eureka-server
    networks:
      - etudiants_network
    restart: unless-stopped
```

---

## Issue 4: Grading Service - Missing Test Data

**File**: `grading-service/src/main/resources/` (missing `data.sql`)  
**Severity**: 🟡 MAJOR - Service starts but empty  
**Impact**: No grades in system until manually created

### What's Missing:
The file `grading-service/src/main/resources/data.sql` doesn't exist.

### Solution:
Create the file with test data:

```sql
-- Initialize test grades for students
-- Note: student IDs must match students in etudiants table (1-7)

INSERT INTO notes (student_id, matiere, valeur) VALUES
    (1, 'Mathématiques', 15.5),
    (1, 'Programmation', 18.0),
    (1, 'Anglais', 14.0),
    (2, 'Mathématiques', 16.0),
    (2, 'Programmation', 17.5),
    (2, 'Anglais', 15.5),
    (3, 'Mathématiques', 13.5),
    (3, 'Programmation', 14.0),
    (3, 'Anglais', 16.0),
    (4, 'Mathématiques', 17.0),
    (4, 'Programmation', 16.0),
    (4, 'Anglais', 17.5),
    (5, 'Mathématiques', 14.5),
    (5, 'Programmation', 15.5),
    (5, 'Anglais', 13.0),
    (6, 'Mathématiques', 18.0),
    (6, 'Programmation', 19.0),
    (6, 'Anglais', 18.5),
    (7, 'Mathématiques', 16.5),
    (7, 'Programmation', 17.0),
    (7, 'Anglais', 15.5);
```

**Enable data loading** in `grading-service/src/main/resources/application.properties`:
```properties
spring.sql.init.mode=always
spring.jpa.defer-datasource-initialization=true
```

---

## Issue 5: Frontend - Placeholder Only

**File**: `frontend/` directory  
**Severity**: 🔴 CRITICAL - No UI  
**Impact**: Users cannot interact with the system via web

### Current Status:
- Only `Dockerfile` with `sleep infinity`
- Only `README.md` with requirements
- No actual Next.js project

### Solution:
Complete Next.js implementation needed (see PHASE4_ANALYSIS.md for details)

---

## Issue 6: Missing GitHub Actions Workflows

**File**: `.github/workflows/` (doesn't exist)  
**Severity**: 🟡 MAJOR - No CI/CD  
**Impact**: No automated testing, building, or deployment

### Solution:
Create workflow files (see PHASE4_ANALYSIS.md for details)

---

## 🔧 Quick Fix Checklist

- [ ] Fix eureka-server Dockerfile (2 minutes)
- [ ] Fix api-gateway Dockerfile (2 minutes)
- [ ] Fix docker-compose.yml grading-service config (5 minutes)
- [ ] Create grading-service data.sql (10 minutes)
- [ ] **Total time: ~20 minutes**

---

## ⏱️ Testing After Fixes

```bash
# Navigate to project directory
cd c:\Users\NAWRES\Desktop\app flutter\projet-etudiants

# Stop and clean old containers
docker-compose down -v

# Build and start services
docker-compose up --build

# In another terminal, test endpoints
curl http://localhost:8080/api/etudiants
curl http://localhost:8080/api/notes
curl http://localhost:8761/eureka/apps

# Expected responses:
# - Etudiants: JSON array with 7 students
# - Notes: JSON array with ~21 grades
# - Eureka: XML/JSON with registered services
```

---

## 📋 After Fixes

Once these issues are fixed:
1. Docker Compose stack should start successfully
2. All 5 backend services will be running
3. Eureka dashboard will show all registered services
4. API Gateway will route requests correctly
5. Database will be populated with test data
6. Grading service will validate student existence

Then proceed with Phase 4 implementation (Frontend, CI/CD, etc.)

---

**Priority**: Fix these BEFORE starting any Phase 4 work!
