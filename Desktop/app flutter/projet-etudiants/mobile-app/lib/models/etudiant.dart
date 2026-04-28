class Etudiant {
  final int id;
  final String cin;
  final String nom;
  final String? dateNaissance;
  final String? departement;

  Etudiant({
    required this.id,
    required this.cin,
    required this.nom,
    this.dateNaissance,
    this.departement,
  });

  factory Etudiant.fromJson(Map<String, dynamic> json) {
    return Etudiant(
      id: json['id'],
      cin: json['cin'],
      nom: json['nom'],
      dateNaissance: json['dateNaissance'],
      departement: json['departement'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cin': cin,
      'nom': nom,
      'dateNaissance': dateNaissance,
      'departement': departement,
    };
  }
}
