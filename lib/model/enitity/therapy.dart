class Therapy {
  final String? id;
  final int dose;
  final String name;
  final bool isInsulin;

  Therapy({
    this.id,
    required this.name,
    required this.dose,
    required this.isInsulin,
  });

  factory Therapy.fromMap(map, String id) {
    return Therapy(
      id: id,
      name: map['name'],
      dose: map['dose'],
      isInsulin: map['isInsulin'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dose': dose,
      'isInsulin': isInsulin,
    };
  }
}
