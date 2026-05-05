@echo off
REM Script de vérification du projet Partie 4
REM Windows PowerShell version

echo.
echo ========================================
echo  Verification du Projet Partie 4
echo ========================================
echo.

REM Vérifier Docker
echo [1] Verification de Docker...
docker --version
if %errorlevel% neq 0 (
    echo ERROR: Docker n'est pas installe
    exit /b 1
)

REM Vérifier Docker Compose
echo.
echo [2] Verification de Docker Compose...
docker-compose --version
if %errorlevel% neq 0 (
    echo ERROR: Docker Compose n'est pas installe
    exit /b 1
)

REM Vérifier Maven
echo.
echo [3] Verification de Maven...
mvn --version
if %errorlevel% neq 0 (
    echo ERROR: Maven n'est pas installe
    exit /b 1
)

REM Vérifier Node.js
echo.
echo [4] Verification de Node.js...
node --version
npm --version
if %errorlevel% neq 0 (
    echo ERROR: Node.js n'est pas installe
    exit /b 1
)

REM Vérifier les fichiers critiques
echo.
echo [5] Verification des fichiers...
if not exist "docker-compose.yml" (
    echo ERROR: docker-compose.yml manquant
    exit /b 1
)
if not exist "frontend\package.json" (
    echo ERROR: frontend\package.json manquant
    exit /b 1
)
if not exist ".github\workflows\build.yml" (
    echo ERROR: .github\workflows\build.yml manquant
    exit /b 1
)

echo.
echo ========================================
echo  Tous les prerequis sont verifies!
echo ========================================
echo.
echo Demarrage du projet:
echo   docker-compose up --build
echo.
echo Acces a l'application:
echo   Frontend: http://localhost:3000
echo   API: http://localhost:8080
echo   Eureka: http://localhost:8761
echo.
