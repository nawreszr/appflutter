import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/etudiant.dart';
import '../services/etudiant_service.dart';

class EtudiantsListScreen extends StatefulWidget {
  const EtudiantsListScreen({Key? key}) : super(key: key);

  @override
  State<EtudiantsListScreen> createState() => _EtudiantsListScreenState();
}

class _EtudiantsListScreenState extends State<EtudiantsListScreen> {
  late Future<List<Etudiant>> futureEtudiants;
  late Future<List<String>> futureDepartements;
  final EtudiantService service = EtudiantService();
  String? selectedDepartement;

  @override
  void initState() {
    super.initState();
    futureDepartements = service.getAllDepartements();
    futureEtudiants = service.getAllEtudiants();
  }

  String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'N/A';
    try {
      final DateTime date = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  void _onDepartementChanged(String? departement) {
    setState(() {
      selectedDepartement = departement;
      if (departement == null) {
        futureEtudiants = service.getAllEtudiants();
      } else {
        futureEtudiants = service.getEtudiantsByDepartement(departement);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Étudiants'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Département Filter
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<List<String>>(
              future: futureDepartements,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 50,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (snapshot.hasError) {
                  return Text('Erreur: ${snapshot.error}');
                }

                final departements = snapshot.data ?? [];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sélectionner un département:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButton<String?>(
                      value: selectedDepartement,
                      hint: const Text('Tous les départements'),
                      isExpanded: true,
                      items: [
                        const DropdownMenuItem<String?>(
                          value: null,
                          child: Text('Tous les départements'),
                        ),
                        ...departements.map((dept) {
                          return DropdownMenuItem<String?>(
                            value: dept,
                            child: Text(dept),
                          );
                        }),
                      ],
                      onChanged: _onDepartementChanged,
                      underline: Container(
                        height: 2,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Étudiants List
          Expanded(
            child: RefreshIndicator(
              color: Colors.blue,
              onRefresh: () async {
                setState(() {
                  if (selectedDepartement == null) {
                    futureEtudiants = service.getAllEtudiants();
                  } else {
                    futureEtudiants = service.getEtudiantsByDepartement(selectedDepartement!);
                  }
                });
                await Future.delayed(const Duration(milliseconds: 500));
              },
              child: FutureBuilder<List<Etudiant>>(
                future: futureEtudiants,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 64, color: Colors.red),
                          const SizedBox(height: 16),
                          Text(
                            'Erreur: ${snapshot.error}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, color: Colors.red),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (selectedDepartement == null) {
                                  futureEtudiants = service.getAllEtudiants();
                                } else {
                                  futureEtudiants = service.getEtudiantsByDepartement(selectedDepartement!);
                                }
                              });
                            },
                            child: const Text('Réessayer'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('Aucun étudiant trouvé'),
                    );
                  }

                  final etudiants = snapshot.data!;

                  return ListView.builder(
                    itemCount: etudiants.length,
                    itemBuilder: (context, index) {
                      final etudiant = etudiants[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        elevation: 2,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(
                            etudiant.nom,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 6),
                              Text('CIN: ${etudiant.cin}'),
                              Text('Naissance: ${formatDate(etudiant.dateNaissance)}'),
                              if (etudiant.departement != null)
                                Text('Département: ${etudiant.departement}'),
                            ],
                          ),
                          isThreeLine: true,
                          trailing: const Icon(Icons.person, color: Colors.blue),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
