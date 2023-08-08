import 'package:diabuddy/model/enitity/activity.dart';
import 'package:diabuddy/model/enitity/dish.dart';
import 'package:diabuddy/model/enitity/enum/glucose_type.dart';
import 'package:diabuddy/model/enitity/enum/meal_type.dart';
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

class GetGlucoseReadingsForPeriod extends UserEvent {
  final DateTime start;
  final DateTime end;

  GetGlucoseReadingsForPeriod(this.start, this.end);

  @override
  List<Object?> get props => [start, end];
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

class GetDishes extends UserEvent {
  @override
  List<Object?> get props => [];
}

class EditDish extends UserEvent {
  final Dish dish;

  EditDish(this.dish);

  @override
  List<Object?> get props => [dish];
}

class GetAllGlucoseReadings extends UserEvent {
  @override
  List<Object?> get props => [];
}

class GetGlucoseReadingById extends UserEvent {
  final String glucoseReadingId;

  GetGlucoseReadingById(this.glucoseReadingId);

  @override
  List<Object?> get props => [glucoseReadingId];
}

class UpdateGlucoseReading extends UserEvent {
  final String glucoseReadingId;
  final double glucoseLevel;
  final GlucoseTiming glucoseTiming;
  final MealType? mealType;

  UpdateGlucoseReading(
    this.glucoseLevel,
    this.glucoseTiming,
    this.glucoseReadingId,
    this.mealType,
  );

  @override
  List<Object?> get props =>
      [glucoseReadingId, glucoseTiming, glucoseLevel, mealType];
}

class UpdateGlucoseReadingActivity extends UserEvent {
  final String glucoseReadingId;
  final Activity activity;

  UpdateGlucoseReadingActivity(
    this.glucoseReadingId,
    this.activity,
  );

  @override
  List<Object?> get props => [glucoseReadingId, activity];
}

class GetGlucoseReadingDishes extends UserEvent {
  final String glucoseReadingId;

  GetGlucoseReadingDishes(this.glucoseReadingId);

  @override
  List<Object?> get props => [glucoseReadingId];
}

class DeleteDish extends UserEvent {
  final String glucoseReadingId;
  final String dishId;

  DeleteDish(this.glucoseReadingId, this.dishId);

  @override
  List<Object?> get props => [glucoseReadingId, dishId];
}

class AddDishToGlucoseReading extends UserEvent {
  final Dish dish;
  final String glucoseReadingId;

  AddDishToGlucoseReading(this.dish, this.glucoseReadingId);

  @override
  List<Object?> get props => [dish, glucoseReadingId];
}

class GetUserProfileData extends UserEvent {
  @override
  List<Object?> get props => [];
}

class UpdateUserData extends UserEvent {
  final int weight;
  final String fullName;

  UpdateUserData(this.weight, this.fullName);

  @override
  List<Object?> get props => [weight, fullName];
}

class CheckIfUserExists extends UserEvent {
  @override
  List<Object?> get props => [];
}