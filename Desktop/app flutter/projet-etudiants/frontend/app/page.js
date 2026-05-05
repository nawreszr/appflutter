'use client'

import Link from 'next/link'

export default function Home() {
  return (
    <div className="max-w-7xl mx-auto px-4 py-12">
      <div className="bg-white rounded-lg shadow-lg p-8 mb-8">
        <h2 className="text-4xl font-bold text-gray-800 mb-4">
          Bienvenue ! 👋
        </h2>
        <p className="text-gray-600 text-lg mb-6">
          Système de gestion intégré pour les étudiants, notes et départements.
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <Link href="/etudiants">
          <div className="bg-blue-500 text-white rounded-lg shadow-lg p-8 cursor-pointer hover:shadow-xl hover:scale-105 transition transform">
            <h3 className="text-2xl font-bold mb-2">📖 Étudiants</h3>
            <p>Gérer la liste des étudiants</p>
          </div>
        </Link>

        <Link href="/notes">
          <div className="bg-green-500 text-white rounded-lg shadow-lg p-8 cursor-pointer hover:shadow-xl hover:scale-105 transition transform">
            <h3 className="text-2xl font-bold mb-2">📊 Notes</h3>
            <p>Consulter et gérer les notes</p>
          </div>
        </Link>

        <Link href="/departements">
          <div className="bg-purple-500 text-white rounded-lg shadow-lg p-8 cursor-pointer hover:shadow-xl hover:scale-105 transition transform">
            <h3 className="text-2xl font-bold mb-2">🏢 Départements</h3>
            <p>Voir les départements</p>
          </div>
        </Link>
      </div>

      <div className="bg-white rounded-lg shadow-lg p-8 mt-8">
        <h3 className="text-2xl font-bold text-gray-800 mb-4">
          À propos de l'Application
        </h3>
        <ul className="text-gray-600 space-y-2">
          <li>✅ API Gateway: http://localhost:8080</li>
          <li>✅ Service Découverte: http://localhost:8761</li>
          <li>✅ Base de données PostgreSQL</li>
          <li>✅ Microservices architecture</li>
        </ul>
      </div>
    </div>
  )
}
