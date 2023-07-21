import 'package:diabuddy/model/enitity/dish.dart';
import 'package:diabuddy/model/enitity/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {}

class ProfileUpdateEvent extends UserEvent {
  final int weight;
  final DateTime dateOfBirth;

  ProfileUpdateEvent({
    required this.weight,
    required this.dateOfBirth,
  });

  @override
  List<Object?> get props => [weight, dateOfBirth];
}

class AddMedicationEvent extends UserEvent {
  final String medicationName;
  final int dailyMedicationIntake;
  final bool isInsulin;
  final int? insulinDose;

  AddMedicationEvent({
    required this.medicationName,
    required this.dailyMedicationIntake,
    required this.isInsulin,
    this.insulinDose,
  });

  @override
  List<Object?> get props =>
      [medicationName, dailyMedicationIntake, isInsulin, insulinDose];
}

class GetAllMedications extends UserEvent {
  @override
  List<Object?> get props => [];
}

class DeleteMedication extends UserEvent {
  final String medicationId;

  DeleteMedication({required this.medicationId});

  @override
  List<Object?> get props => [medicationId];
}

class GetTodaysGlucoseReadings extends UserEvent {
  @override
  List<Object?> get props => [];
}

class GetGlucoseTargets extends UserEvent {
  @override
  List<Object?> get props => [];
}

class SaveGlucoseTargets extends UserEvent {
  final GlucoseTargets glucoseTargets;

  SaveGlucoseTargets(this.glucoseTargets);

  @override
  List<Object?> get props => [glucoseTargets];
}

class SaveNewDish extends UserEvent {
  final Dish dish;

  SaveNewDish(this.dish);

  @override
  List<Object?> get props => [dish];
}

class GetDishes extends UserEvent{
  @override
  List<Object?> get props => throw UnimplementedError();
}