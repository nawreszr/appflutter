'use client'

import { useEffect, useState } from 'react'
import axios from 'axios'

const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8080/api'

export default function DepartementsPage() {
  const [departements, setDepartements] = useState([])
  const [etudiants, setEtudiants] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    fetchData()
  }, [])

  const fetchData = async () => {
    try {
      setLoading(true)
      const etudiantsRes = await axios.get(`${API_URL}/etudiants`)
      setEtudiants(etudiantsRes.data)

      // Extraire les départements uniques
      const depts = [...new Set(etudiantsRes.data.map(e => e.departement))]
      setDepartements(depts.map(dept => ({
        name: dept,
        count: etudiantsRes.data.filter(e => e.departement === dept).length
      })))
      setError(null)
    } catch (err) {
      console.error('Erreur lors du chargement:', err)
      setError('Erreur lors du chargement des départements')
    } finally {
      setLoading(false)
    }
  }

  const getEtudiantsByDepartement = (dept) => {
    return etudiants.filter(e => e.departement === dept)
  }

  return (
    <div className="max-w-7xl mx-auto px-4 py-8">
      <h2 className="text-3xl font-bold text-gray-800 mb-8">Départements</h2>

      {error && (
        <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
          {error}
        </div>
      )}

      {loading ? (
        <div className="text-center py-8">
          <p className="text-gray-600">Chargement...</p>
        </div>
      ) : departements.length === 0 ? (
        <div className="bg-white rounded-lg shadow-lg p-6 text-center">
          <p className="text-gray-600">Aucun département trouvé</p>
        </div>
      ) : (
        <div className="space-y-6">
          {departements.map((dept) => (
            <div key={dept.name} className="bg-white rounded-lg shadow-lg p-6">
              <h3 className="text-2xl font-bold text-gray-800 mb-4">
                🏢 {dept.name}
              </h3>
              <p className="text-gray-600 mb-4">
                <strong>{dept.count}</strong> étudiant(s)
              </p>

              {getEtudiantsByDepartement(dept.name).length > 0 ? (
                <div className="overflow-x-auto">
                  <table className="w-full text-sm">
                    <thead className="bg-gray-100">
                      <tr>
                        <th className="px-4 py-2 text-left">ID</th>
                        <th className="px-4 py-2 text-left">CIN</th>
                        <th className="px-4 py-2 text-left">Nom</th>
                        <th className="px-4 py-2 text-left">Date de Naissance</th>
                      </tr>
                    </thead>
                    <tbody>
                      {getEtudiantsByDepartement(dept.name).map((etudiant) => (
                        <tr key={etudiant.id} className="border-t hover:bg-gray-50">
                          <td className="px-4 py-2">{etudiant.id}</td>
                          <td className="px-4 py-2">{etudiant.cin}</td>
                          <td className="px-4 py-2">{etudiant.nom}</td>
                          <td className="px-4 py-2">{etudiant.dateNaissance}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              ) : (
                <p className="text-gray-500 italic">Aucun étudiant dans ce département</p>
              )}
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
