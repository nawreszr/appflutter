import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/etudiant.dart';
import '../models/departement.dart';

class EtudiantService {
  // Changez cette URL par l'IP de votre machine
  static const String baseUrl = 'http://192.168.x.x:8080/api';

  Future<List<Etudiant>> getAllEtudiants() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/etudiants'),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Etudiant.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load etudiants: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Etudiant>> getEtudiantsByDepartement(String departement) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/etudiants/departement/$departement'),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Etudiant.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load etudiants by departement: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<String>> getAllDepartements() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/etudiants'),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final Set<String> departements = {};
        for (var json in jsonList) {
          final etudiant = Etudiant.fromJson(json);
          if (etudiant.departement != null) {
            departements.add(etudiant.departement!);
          }
        }
        return departements.toList()..sort();
      } else {
        throw Exception('Failed to load departements: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Etudiant> getEtudiantById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/etudiants/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Etudiant.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load etudiant: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Etudiant> createEtudiant(Etudiant etudiant) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/etudiants'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(etudiant.toJson()),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Etudiant.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create etudiant: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
