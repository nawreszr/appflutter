@echo off
REM Script de démarrage du projet Étudiants pour Windows

echo.
echo ==========================================
echo Projet Etudiants - Demarrage
echo ==========================================
echo.

REM Vérifier Docker
where docker >nul 2>nul
if %errorlevel% neq 0 (
    echo Erreur: Docker n'est pas installe
    exit /b 1
)

where docker-compose >nul 2>nul
if %errorlevel% neq 0 (
    echo Erreur: Docker Compose n'est pas installe
    exit /b 1
)

echo Docker et Docker Compose detected
echo.

REM Vérifier docker-compose.yml
if not exist "docker-compose.yml" (
    echo Erreur: docker-compose.yml non trouve
    exit /b 1
)

echo Demarrage des services Docker...
echo.

REM Lancer les services
docker compose up --build

echo.
echo ==========================================
echo Services lances avec succes!
echo ==========================================
echo.
echo API: http://localhost:8080/api/etudiants
echo PostgreSQL: localhost:5432
echo.
echo Pour arreter: Ctrl+C
echo.
pause
