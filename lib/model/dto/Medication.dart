class Medication {
  Medication({
    required this.dailyIntake,
    required this.insulinUnits,
    required this.isInsulin,
    required this.medicationName,
  });

  final String medicationName;
  final int dailyIntake;
  final int? insulinUnits;
  final bool isInsulin;
}
