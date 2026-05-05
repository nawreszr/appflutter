'use client'

import { useEffect, useState } from 'react'
import axios from 'axios'

const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8080/api'

export default function EtudiantsPage() {
  const [etudiants, setEtudiants] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)
  const [newEtudiant, setNewEtudiant] = useState({
    cin: '',
    nom: '',
    dateNaissance: '',
    departement: 'IT'
  })

  useEffect(() => {
    fetchEtudiants()
  }, [])

  const fetchEtudiants = async () => {
    try {
      setLoading(true)
      const response = await axios.get(`${API_URL}/etudiants`)
      setEtudiants(response.data)
      setError(null)
    } catch (err) {
      console.error('Erreur lors du chargement:', err)
      setError('Erreur lors du chargement des étudiants')
    } finally {
      setLoading(false)
    }
  }

  const handleAddEtudiant = async (e) => {
    e.preventDefault()
    try {
      await axios.post(`${API_URL}/etudiants`, newEtudiant)
      setNewEtudiant({
        cin: '',
        nom: '',
        dateNaissance: '',
        departement: 'IT'
      })
      fetchEtudiants()
    } catch (err) {
      setError('Erreur lors de l\'ajout de l\'étudiant')
    }
  }

  const handleDeleteEtudiant = async (id) => {
    if (window.confirm('Êtes-vous sûr de vouloir supprimer cet étudiant ?')) {
      try {
        await axios.delete(`${API_URL}/etudiants/${id}`)
        fetchEtudiants()
      } catch (err) {
        setError('Erreur lors de la suppression')
      }
    }
  }

  return (
    <div className="max-w-7xl mx-auto px-4 py-8">
      <h2 className="text-3xl font-bold text-gray-800 mb-8">Gestion des Étudiants</h2>

      {error && (
        <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
          {error}
        </div>
      )}

      {/* Formulaire d'ajout */}
      <div className="bg-white rounded-lg shadow-lg p-6 mb-8">
        <h3 className="text-xl font-bold text-gray-800 mb-4">Ajouter un étudiant</h3>
        <form onSubmit={handleAddEtudiant} className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <input
            type="text"
            placeholder="CIN"
            value={newEtudiant.cin}
            onChange={(e) => setNewEtudiant({ ...newEtudiant, cin: e.target.value })}
            className="border border-gray-300 rounded px-3 py-2"
            required
          />
          <input
            type="text"
            placeholder="Nom"
            value={newEtudiant.nom}
            onChange={(e) => setNewEtudiant({ ...newEtudiant, nom: e.target.value })}
            className="border border-gray-300 rounded px-3 py-2"
            required
          />
          <input
            type="date"
            value={newEtudiant.dateNaissance}
            onChange={(e) => setNewEtudiant({ ...newEtudiant, dateNaissance: e.target.value })}
            className="border border-gray-300 rounded px-3 py-2"
            required
          />
          <select
            value={newEtudiant.departement}
            onChange={(e) => setNewEtudiant({ ...newEtudiant, departement: e.target.value })}
            className="border border-gray-300 rounded px-3 py-2"
          >
            <option value="IT">IT</option>
            <option value="GE">GE</option>
            <option value="GM">GM</option>
          </select>
          <button
            type="submit"
            className="md:col-span-2 bg-blue-600 text-white px-6 py-2 rounded hover:bg-blue-700 transition"
          >
            Ajouter
          </button>
        </form>
      </div>

      {/* Liste des étudiants */}
      {loading ? (
        <div className="text-center py-8">
          <p className="text-gray-600">Chargement...</p>
        </div>
      ) : etudiants.length === 0 ? (
        <div className="bg-white rounded-lg shadow-lg p-6 text-center">
          <p className="text-gray-600">Aucun étudiant trouvé</p>
        </div>
      ) : (
        <div className="bg-white rounded-lg shadow-lg overflow-hidden">
          <table className="w-full">
            <thead className="bg-gray-200">
              <tr>
                <th className="px-4 py-2 text-left">ID</th>
                <th className="px-4 py-2 text-left">CIN</th>
                <th className="px-4 py-2 text-left">Nom</th>
                <th className="px-4 py-2 text-left">Date de Naissance</th>
                <th className="px-4 py-2 text-left">Département</th>
                <th className="px-4 py-2 text-center">Actions</th>
              </tr>
            </thead>
            <tbody>
              {etudiants.map((etudiant) => (
                <tr key={etudiant.id} className="border-t hover:bg-gray-50">
                  <td className="px-4 py-2">{etudiant.id}</td>
                  <td className="px-4 py-2">{etudiant.cin}</td>
                  <td className="px-4 py-2">{etudiant.nom}</td>
                  <td className="px-4 py-2">{etudiant.dateNaissance}</td>
                  <td className="px-4 py-2">
                    <span className="bg-blue-100 text-blue-800 px-2 py-1 rounded">
                      {etudiant.departement}
                    </span>
                  </td>
                  <td className="px-4 py-2 text-center">
                    <button
                      onClick={() => handleDeleteEtudiant(etudiant.id)}
                      className="bg-red-600 text-white px-3 py-1 rounded hover:bg-red-700 transition"
                    >
                      Supprimer
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  )
}
