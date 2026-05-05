'use client'

import { useEffect, useState } from 'react'
import axios from 'axios'

const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8080/api'

export default function NotesPage() {
  const [notes, setNotes] = useState([])
  const [etudiants, setEtudiants] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)
  const [newNote, setNewNote] = useState({
    studentId: '',
    matiere: '',
    valeur: ''
  })

  useEffect(() => {
    fetchData()
  }, [])

  const fetchData = async () => {
    try {
      setLoading(true)
      const [notesRes, etudiantsRes] = await Promise.all([
        axios.get(`${API_URL}/notes`),
        axios.get(`${API_URL}/etudiants`)
      ])
      setNotes(notesRes.data)
      setEtudiants(etudiantsRes.data)
      setError(null)
    } catch (err) {
      console.error('Erreur lors du chargement:', err)
      setError('Erreur lors du chargement des données')
    } finally {
      setLoading(false)
    }
  }

  const handleAddNote = async (e) => {
    e.preventDefault()
    try {
      await axios.post(`${API_URL}/notes`, {
        studentId: parseInt(newNote.studentId),
        matiere: newNote.matiere,
        valeur: parseFloat(newNote.valeur)
      })
      setNewNote({ studentId: '', matiere: '', valeur: '' })
      fetchData()
    } catch (err) {
      setError('Erreur lors de l\'ajout de la note')
    }
  }

  const handleDeleteNote = async (id) => {
    if (window.confirm('Êtes-vous sûr de vouloir supprimer cette note ?')) {
      try {
        await axios.delete(`${API_URL}/notes/${id}`)
        fetchData()
      } catch (err) {
        setError('Erreur lors de la suppression')
      }
    }
  }

  const getEtudiantName = (studentId) => {
    const etudiant = etudiants.find(e => e.id === studentId)
    return etudiant ? etudiant.nom : 'Étudiant inconnu'
  }

  const getMoyenne = () => {
    if (notes.length === 0) return 0
    const sum = notes.reduce((acc, note) => acc + note.valeur, 0)
    return (sum / notes.length).toFixed(2)
  }

  return (
    <div className="max-w-7xl mx-auto px-4 py-8">
      <h2 className="text-3xl font-bold text-gray-800 mb-8">Gestion des Notes</h2>

      {error && (
        <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
          {error}
        </div>
      )}

      {/* Statistiques */}
      {notes.length > 0 && (
        <div className="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
          📊 Moyenne générale: <strong>{getMoyenne()} / 20</strong>
        </div>
      )}

      {/* Formulaire d'ajout */}
      <div className="bg-white rounded-lg shadow-lg p-6 mb-8">
        <h3 className="text-xl font-bold text-gray-800 mb-4">Ajouter une note</h3>
        <form onSubmit={handleAddNote} className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <select
            value={newNote.studentId}
            onChange={(e) => setNewNote({ ...newNote, studentId: e.target.value })}
            className="border border-gray-300 rounded px-3 py-2"
            required
          >
            <option value="">Sélectionner un étudiant</option>
            {etudiants.map(etudiant => (
              <option key={etudiant.id} value={etudiant.id}>
                {etudiant.nom} ({etudiant.cin})
              </option>
            ))}
          </select>
          <input
            type="text"
            placeholder="Matière"
            value={newNote.matiere}
            onChange={(e) => setNewNote({ ...newNote, matiere: e.target.value })}
            className="border border-gray-300 rounded px-3 py-2"
            required
          />
          <input
            type="number"
            placeholder="Note (0-20)"
            min="0"
            max="20"
            step="0.5"
            value={newNote.valeur}
            onChange={(e) => setNewNote({ ...newNote, valeur: e.target.value })}
            className="border border-gray-300 rounded px-3 py-2"
            required
          />
          <button
            type="submit"
            className="md:col-span-2 bg-green-600 text-white px-6 py-2 rounded hover:bg-green-700 transition"
          >
            Ajouter
          </button>
        </form>
      </div>

      {/* Liste des notes */}
      {loading ? (
        <div className="text-center py-8">
          <p className="text-gray-600">Chargement...</p>
        </div>
      ) : notes.length === 0 ? (
        <div className="bg-white rounded-lg shadow-lg p-6 text-center">
          <p className="text-gray-600">Aucune note trouvée</p>
        </div>
      ) : (
        <div className="bg-white rounded-lg shadow-lg overflow-hidden">
          <table className="w-full">
            <thead className="bg-gray-200">
              <tr>
                <th className="px-4 py-2 text-left">ID</th>
                <th className="px-4 py-2 text-left">Étudiant</th>
                <th className="px-4 py-2 text-left">Matière</th>
                <th className="px-4 py-2 text-left">Note</th>
                <th className="px-4 py-2 text-center">Actions</th>
              </tr>
            </thead>
            <tbody>
              {notes.map((note) => (
                <tr key={note.id} className="border-t hover:bg-gray-50">
                  <td className="px-4 py-2">{note.id}</td>
                  <td className="px-4 py-2">{getEtudiantName(note.studentId)}</td>
                  <td className="px-4 py-2">{note.matiere}</td>
                  <td className="px-4 py-2">
                    <span className={`px-2 py-1 rounded ${
                      note.valeur >= 12
                        ? 'bg-green-100 text-green-800'
                        : note.valeur >= 10
                        ? 'bg-yellow-100 text-yellow-800'
                        : 'bg-red-100 text-red-800'
                    }`}>
                      {note.valeur} / 20
                    </span>
                  </td>
                  <td className="px-4 py-2 text-center">
                    <button
                      onClick={() => handleDeleteNote(note.id)}
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
