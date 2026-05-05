#!/bin/bash

# Script de vérification du projet Partie 4
# Unix/Linux/Mac version

echo ""
echo "========================================"
echo " Verification du Projet Partie 4"
echo "========================================"
echo ""

# Vérifier Docker
echo "[1] Verification de Docker..."
if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker n'est pas installé"
    exit 1
fi
docker --version

# Vérifier Docker Compose
echo ""
echo "[2] Verification de Docker Compose..."
if ! command -v docker-compose &> /dev/null; then
    echo "ERROR: Docker Compose n'est pas installé"
    exit 1
fi
docker-compose --version

# Vérifier Maven
echo ""
echo "[3] Verification de Maven..."
if ! command -v mvn &> /dev/null; then
    echo "ERROR: Maven n'est pas installé"
    exit 1
fi
mvn --version

# Vérifier Node.js
echo ""
echo "[4] Verification de Node.js..."
if ! command -v node &> /dev/null; then
    echo "ERROR: Node.js n'est pas installé"
    exit 1
fi
node --version
npm --version

# Vérifier les fichiers critiques
echo ""
echo "[5] Verification des fichiers..."
files=(
    "docker-compose.yml"
    "frontend/package.json"
    ".github/workflows/build.yml"
    "eureka-server/Dockerfile"
    "api-gateway/Dockerfile"
)

for file in "${files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "ERROR: $file manquant"
        exit 1
    fi
done

echo ""
echo "========================================"
echo " Tous les prerequis sont verifies!"
echo "========================================"
echo ""
echo "Demarrage du projet:"
echo "  docker-compose up --build"
echo ""
echo "Acces a l'application:"
echo "  Frontend: http://localhost:3000"
echo "  API: http://localhost:8080"
echo "  Eureka: http://localhost:8761"
echo ""
