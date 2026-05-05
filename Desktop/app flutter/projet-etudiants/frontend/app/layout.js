import './globals.css'

export const metadata = {
  title: 'Gestion des Étudiants',
  description: 'Application de gestion des étudiants, notes et départements',
}

export default function RootLayout({ children }) {
  return (
    <html lang="fr">
      <body className="bg-gray-50">
        <nav className="bg-blue-600 text-white p-4 shadow-lg">
          <div className="max-w-7xl mx-auto flex justify-between items-center">
            <h1 className="text-2xl font-bold">📚 Gestion Étudiants</h1>
            <ul className="flex gap-6">
              <li>
                <a href="/" className="hover:text-blue-200 transition">
                  Accueil
                </a>
              </li>
              <li>
                <a href="/etudiants" className="hover:text-blue-200 transition">
                  Étudiants
                </a>
              </li>
              <li>
                <a href="/notes" className="hover:text-blue-200 transition">
                  Notes
                </a>
              </li>
              <li>
                <a href="/departements" className="hover:text-blue-200 transition">
                  Départements
                </a>
              </li>
            </ul>
          </div>
        </nav>

        <main className="min-h-screen">
          {children}
        </main>

        <footer className="bg-gray-800 text-white p-4 mt-12">
          <div className="max-w-7xl mx-auto text-center">
            <p>&copy; 2025 Système Gestion Étudiants - Tous droits réservés</p>
          </div>
        </footer>
      </body>
    </html>
  )
}
