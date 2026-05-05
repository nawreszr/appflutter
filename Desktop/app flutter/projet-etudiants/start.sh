#!/bin/bash

# Script de démarrage du projet Étudiants

set -e

echo "=========================================="
echo "Projet Étudiants - Démarrage"
echo "=========================================="
echo ""

# Vérifier Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker n'est pas installé. Veuillez installer Docker."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose n'est pas installé."
    exit 1
fi

echo "✅ Docker et Docker Compose sont installés"
echo ""

# Vérifier la structure
if [ ! -f "docker-compose.yml" ]; then
    echo "❌ Erreur: docker-compose.yml non trouvé"
    exit 1
fi

echo "📦 Démarrage des services Docker..."
echo ""

# Lancer les services
docker compose up --build

echo ""
echo "=========================================="
echo "✅ Services lancés avec succès!"
echo "=========================================="
echo ""
echo "📍 Accès à l'API: http://localhost:8080/api/etudiants"
echo "📍 PostgreSQL: localhost:5432"
echo ""
echo "Pour arrêter: Ctrl+C"
echo ""
