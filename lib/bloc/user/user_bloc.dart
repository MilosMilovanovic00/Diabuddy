import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/model/enitity/glucose_reading.dart';
import 'package:diabuddy/model/enitity/medication.dart';
import 'package:diabuddy/repository/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({
    required this.userRepository,
  }) : super(InitialUserState()) {
    on<ProfileUpdateEvent>(_onUpdateProfile);
    on<AddMedicationEvent>(_onAddMedication);
    on<GetAllMedications>(_onFetchMedication);
    on<DeleteMedication>(_onDeleteMedication);
    on<GetTodaysGlucoseReadings>(_onFetchGlucoseReadingsToday);
    on<GetGlucoseTargets>(_onFetchGlucoseTargets);
    on<SaveGlucoseTargets>(_onSaveGlucoseTargets);
    on<SaveNewDish>(_onSaveNewDish);
    on<GetDishes>(_onFetchDishes);
  }

  FutureOr<void> _onUpdateProfile(
    ProfileUpdateEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      await userRepository.updatePersonalData(
        weight: event.weight,
        dateOfBirth: event.dateOfBirth,
      );
      emit(UserProfileUpdateSuccessful());
    } catch (_) {
      emit(UserProfileUpdateFailed());
    }
  }

  FutureOr<void> _onAddMedication(
    AddMedicationEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      Medication medication = Medication(
        medicationName: event.medicationName,
        dailyMedicationIntake: event.dailyMedicationIntake,
        isInsulin: event.isInsulin,
        averageInsulinUnits: event.insulinDose,
      );
      await userRepository.addMedication(medication: medication);
      emit(SuccessfulMedicationAddition());
    } catch (_) {
      emit(MedicationAdditionFailed());
    }
  }

  FutureOr<void> _onFetchMedication(
    GetAllMedications event,
    Emitter<UserState> emit,
  ) async {
    try {
      List<Medication> medicine = await userRepository.fetchMedication();
      emit(FetchedMedicationData(medicine));
    } catch (_) {
      emit(FetchedMedicationDataFailed());
    }
  }

  FutureOr<void> _onDeleteMedication(
    DeleteMedication event,
    Emitter<UserState> emit,
  ) async {
    try {
      await userRepository.deleteMedication(event.medicationId);
      List<Medication> medicine = await userRepository.fetchMedication();
      emit(FetchedMedicationData(medicine));
    } catch (_) {
      emit(FetchedMedicationDataFailed());
    }
  }

  FutureOr<void> _onFetchGlucoseReadingsToday(
    GetTodaysGlucoseReadings event,
    Emitter<UserState> emit,
  ) async {
    try {
      List<GlucoseReading> readings =
          await userRepository.fetchTodaysGlucoseReadings();
      if (readings.isEmpty) {
        emit(FetchedTodayGlucoseReadingsFailed());
      }
      emit(FetchedTodayGlucoseReadingsSuccess(readings));
    } catch (_) {
      emit(FetchedTodayGlucoseReadingsFailed());
    }
  }

  FutureOr<void> _onFetchGlucoseTargets(
    GetGlucoseTargets event,
    Emitter<UserState> emit,
  ) async {
    try {
      var glucoseTargets = await userRepository.fetchGlucoseTargets();
      if (glucoseTargets == null) {
        emit(FetchedGlucoseTargetsFailed());
      } else {
        emit(FetchedGlucoseTargets(glucoseTargets));
      }
    } catch (_) {
      emit(FetchedGlucoseTargetsFailed());
    }
  }

  FutureOr<void> _onSaveGlucoseTargets(
    SaveGlucoseTargets event,
    Emitter<UserState> emit,
  ) async {
    try {
      await userRepository.saveGlucoseTargets(event.glucoseTargets);
      emit(GlucoseTargetsUpdated());
    } catch (_) {
      emit(GlucoseTargetsUpdateFailed());
    }
  }

  FutureOr<void> _onSaveNewDish(
    SaveNewDish event,
    Emitter<UserState> emit,
  ) async {
    try {
      await userRepository.saveNewDish(event.dish);
      emit(NewDishSaved());
    } catch (_) {
      emit(NewDishSavingFailed());
    }
  }

  FutureOr<void> _onFetchDishes(
    GetDishes event,
    Emitter<UserState> emit,
  ) async {
    try {
      var dishes = await userRepository.fetchDishes();
      if (dishes == null) {
        emit(FetchedDishesFailed());
      } else {
        emit(FetchedDishes(dishes));
      }
    } catch (_) {
      emit(FetchedDishesFailed());
    }
  }
}
