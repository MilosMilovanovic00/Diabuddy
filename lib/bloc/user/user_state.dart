import 'package:diabuddy/model/enitity/dish.dart';
import 'package:diabuddy/model/enitity/glucose_reading.dart';
import 'package:diabuddy/model/enitity/medication.dart';
import 'package:diabuddy/model/enitity/therapy.dart';
import 'package:diabuddy/model/enitity/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {}

class InitialUserState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserProfileUpdateSuccessful extends UserState {
  @override
  List<Object?> get props => [];
}

class UserProfileUpdateFailed extends UserState {
  final Exception? exception;

  UserProfileUpdateFailed({this.exception});

  @override
  List<Object?> get props => [exception];
}

class SuccessfulMedicationAddition extends UserState {
  @override
  List<Object?> get props => [];
}

class MedicationAdditionFailed extends UserState {
  final Exception? exception;

  MedicationAdditionFailed({this.exception});

  @override
  List<Object?> get props => [exception];
}

class FetchedMedicationData extends UserState {
  final List<Medication> medicine;

  FetchedMedicationData(this.medicine);

  @override
  List<Object?> get props => [medicine];
}

class FetchedMedicationDataFailed extends UserState {
  @override
  List<Object?> get props => [];
}

class SuccessfullySavedGlucoseTargets extends UserState {
  @override
  List<Object?> get props => [];
}

class FailedSavingGlucoseTargets extends UserState {
  @override
  List<Object?> get props => [];
}

class FetchedTodayGlucoseReadingsSuccess extends UserState {
  final List<GlucoseReading> readings;

  FetchedTodayGlucoseReadingsSuccess(this.readings);

  @override
  List<Object?> get props => [readings];
}

class FetchedTodayGlucoseReadingsFailed extends UserState {
  @override
  List<Object?> get props => [];
}

class FetchedGlucoseTargets extends UserState {
  final GlucoseTargets glucoseTargets;

  FetchedGlucoseTargets(this.glucoseTargets);

  @override
  List<Object?> get props => [glucoseTargets];
}

class FetchedGlucoseTargetsFailed extends UserState {
  @override
  List<Object?> get props => [];
}

class GlucoseTargetsUpdated extends UserState {
  @override
  List<Object?> get props => [];
}

class GlucoseTargetsUpdateFailed extends UserState {
  @override
  List<Object?> get props => [];
}

class NewDishSaved extends UserState {
  @override
  List<Object?> get props => [];
}

class NewDishSavingFailed extends UserState {
  @override
  List<Object?> get props => [];
}

class FetchedDishes extends UserState {
  final List<Dish> dishes;

  FetchedDishes(this.dishes);

  @override
  List<Object?> get props => [dishes];
}

class FetchedDishesFailed extends UserState {
  @override
  List<Object?> get props => [];
}

class DishUpdated extends UserState {
  @override
  List<Object?> get props => [];
}

class DishUpdatedFailed extends UserState {
  @override
  List<Object?> get props => [];
}

class FetchedAllGlucoseReadings extends UserState {
  final List<GlucoseReading> glucoseReadings;

  FetchedAllGlucoseReadings(this.glucoseReadings);

  @override
  List<Object?> get props => [glucoseReadings];
}

class FetchedAllGlucoseReadingsFailed extends UserState {
  @override
  List<Object?> get props => [];
}

class FetchedGlucoseReading extends UserState {
  final GlucoseReading glucoseReading;
  final List<Therapy> therapy;
  final List<Dish> dishes;

  FetchedGlucoseReading(this.glucoseReading, this.therapy, this.dishes);

  @override
  List<Object?> get props => [glucoseReading, therapy, dishes];
}

class FetchedGlucoseReadingFailed extends UserState {
  @override
  List<Object?> get props => [];
}

class SuccessfullyUpdatedGlucoseReading extends UserState {
  @override
  List<Object?> get props => [];
}

class UpdateGlucoseReadingFailed extends UserState {
  @override
  List<Object?> get props => [];
}

class SuccessfullyUpdatedGlucoseReadingActivity extends UserState {
  @override
  List<Object?> get props => [];
}

class UpdateGlucoseReadingActivityFailed extends UserState {
  @override
  List<Object?> get props => [];
}

class FetchedGlucoseReadingDishes extends UserState {
  final List<Dish> dishes;

  FetchedGlucoseReadingDishes(this.dishes);

  @override
  List<Object?> get props => [dishes];
}

class FetchedGlucoseReadingDishesFailed extends UserState {
  @override
  List<Object?> get props => [];
}

class DeletingDishFailed extends UserState {
  @override
  List<Object?> get props => [];
}

class AddedDishToGlucoseReading extends UserState {
  @override
  List<Object?> get props => [];
}

class AddingDishToGlucoseReadingFailed extends UserState {
  @override
  List<Object?> get props => [];
}

class FetchedUserData extends UserState {
  final UserModel user;

  FetchedUserData(this.user);

  @override
  List<Object?> get props => [user];
}

class FetchedUserDataFailed extends UserState {
  @override
  List<Object?> get props => [];
}

class UserSetupAccountFinished extends UserState {
  @override
  List<Object?> get props => [];
}

class UserSetupAccountNotFinished extends UserState {
  final int screenNumber;

  UserSetupAccountNotFinished(this.screenNumber);

  @override
  List<Object?> get props => [screenNumber];
}

class UserHasNoAccount extends UserState {
  @override
  List<Object?> get props => [];
}

class FetchedGlucoseReadingMedication extends UserState {
  final List<Therapy> therapies;

  FetchedGlucoseReadingMedication(this.therapies);

  @override
  List<Object?> get props => [therapies];
}

class FetchedGlucoseReadingMedicationFailed extends UserState {
  @override
  List<Object?> get props => [];
}

class SavingGlucoseReadingTherapyFailed extends UserState {
  @override
  List<Object?> get props => [];
}

class SavedGlucoseReadingTherapy extends UserState {
  @override
  List<Object?> get props => [];
}

