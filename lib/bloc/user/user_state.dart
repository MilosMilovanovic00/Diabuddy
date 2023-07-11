import 'package:diabuddy/model/enitity/medication.dart';

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

