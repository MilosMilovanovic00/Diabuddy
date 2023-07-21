class Dish {
  final String id;
  final String name;
  final int carbohydrateValue;
  final int preferredGrams;

  Dish({
    required this.id,
    required this.name,
    required this.carbohydrateValue,
    required this.preferredGrams,
  });

  factory Dish.fromMap(map, id) {
    return Dish(
      id: id,
      name: map['name'],
      carbohydrateValue: map['carbohydrateValue'],
      preferredGrams: map['preferredGrams'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'carbohydrateValue': carbohydrateValue,
      'preferredGrams': preferredGrams,
    };
  }
}
