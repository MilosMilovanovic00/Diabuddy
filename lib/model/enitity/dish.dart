class Dish {
  final String? id;
  final String name;
  final int carbohydrateValue;
  final int grams;

  Dish({
    this.id,
    required this.name,
    required this.carbohydrateValue,
    required this.grams,
  });

  factory Dish.fromMap(map, id) {
    return Dish(
      id: id,
      name: map['name'],
      carbohydrateValue: map['carbohydrateValue'],
      grams: map['grams'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'carbohydrateValue': carbohydrateValue,
      'grams': grams,
    };
  }
}
