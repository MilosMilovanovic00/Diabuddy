class Medication {
  final String medicineName;
  final int dailyMedicationIntake;
  final bool isInsulin;
  final int? averageInsulinUnits;

  Medication({
    required this.medicineName,
    required this.dailyMedicationIntake,
    required this.isInsulin,
    this.averageInsulinUnits,
  });
}
