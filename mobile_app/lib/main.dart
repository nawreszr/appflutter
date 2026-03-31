import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ===== MODÈLE =====
class Etudiant {
  final int id;
  final String cin;
  final String nom;
  final String dateNaissance;

  Etudiant({
    required this.id,
    required this.cin,
    required this.nom,
    required this.dateNaissance,
  });

  factory Etudiant.fromJson(Map<String, dynamic> json) {
    return Etudiant(
      id: json['id'],
      cin: json['cin'],
      nom: json['nom'],
      dateNaissance: json['dateNaissance'].toString(),
    );
  }
}

// ===== APP =====
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liste Étudiants',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const EtudiantPage(),
    );
  }
}

class EtudiantPage extends StatefulWidget {
  const EtudiantPage({super.key});

  @override
  State<EtudiantPage> createState() => _EtudiantPageState();
}

class _EtudiantPageState extends State<EtudiantPage> {
  List<Etudiant> etudiants = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchEtudiants();
  }

  Future<void> fetchEtudiants() async {
    final response = await http.get(
      Uri.parse('http://localhost:8081/api/etudiants'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      setState(() {
        etudiants = data.map((e) => Etudiant.fromJson(e)).toList();
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liste des Étudiants')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: etudiants.length,
              itemBuilder: (context, index) {
                final e = etudiants[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(e.nom),
                    subtitle: Text('CIN: ${e.cin}\nNé le: ${e.dateNaissance}'),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}