import 'package:diabuddy/model/enitity/dish.dart';
import 'package:diabuddy/model/enitity/glucose_reading.dart';
import 'package:diabuddy/model/enitity/medication.dart';
import 'package:diabuddy/model/enitity/user_model.dart';

abstract class UserState {}

class InitialUserState extends UserState {}

class UserProfileUpdateSuccessful extends UserState {}

class UserProfileUpdateFailed extends UserState {
  final Exception? exception;

  UserProfileUpdateFailed({this.exception});
}

class SuccessfulMedicationAddition extends UserState {}

class MedicationAdditionFailed extends UserState {
  final Exception? exception;

  MedicationAdditionFailed({this.exception});
}

class FetchedMedicationData extends UserState {
  final List<Medication> medicine;

  FetchedMedicationData(this.medicine);
}

class FetchedMedicationDataFailed extends UserState {}

class SuccessfullySavedGlucoseTargets extends UserState {}

class FailedSavingGlucoseTargets extends UserState {}

class FetchedTodayGlucoseReadingsSuccess extends UserState {
  final List<GlucoseReading> readings;

  FetchedTodayGlucoseReadingsSuccess(this.readings);
}

class FetchedTodayGlucoseReadingsFailed extends UserState {}

class FetchedGlucoseTargets extends UserState {
  final GlucoseTargets glucoseTargets;

  FetchedGlucoseTargets(this.glucoseTargets);
}

class FetchedGlucoseTargetsFailed extends UserState {}

class GlucoseTargetsUpdated extends UserState {}

class GlucoseTargetsUpdateFailed extends UserState {}

class NewDishSaved extends UserState {}

class NewDishSavingFailed extends UserState {}

class FetchedDishes extends UserState {
  final List<Dish> dishes;

  FetchedDishes(this.dishes);
}

class FetchedDishesFailed extends UserState {}
