class Departement {
  final String name;

  Departement({required this.name});

  factory Departement.fromJson(Map<String, dynamic> json) {
    return Departement(
      name: json['name'] ?? json,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
