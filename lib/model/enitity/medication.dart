import 'package:equatable/equatable.dart';

class Medication extends Equatable {
  final String? medicationId;
  final String? medicationName;
  final int? dailyMedicationIntake;
  final bool? isInsulin;
  final int? averageInsulinUnits;

  const Medication({
    this.medicationId,
    this.medicationName,
    this.dailyMedicationIntake,
    this.isInsulin,
    this.averageInsulinUnits,
  });

  @override
  List<Object?> get props => [
        medicationId,
        medicationName,
        dailyMedicationIntake,
        isInsulin,
        averageInsulinUnits
      ];

  factory Medication.fromMap(map,id) {
    return Medication(
      medicationId: id,
      medicationName: map['medicationName'],
      dailyMedicationIntake: map['dailyMedicationIntake'],
      isInsulin: map['isInsulin'],
      averageInsulinUnits: map['averageInsulinUnits'] ,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'medicationName': medicationName,
      'isInsulin': isInsulin,
      'dailyMedicationIntake': dailyMedicationIntake,
      'averageInsulinUnits': averageInsulinUnits ,
    };
  }
}
