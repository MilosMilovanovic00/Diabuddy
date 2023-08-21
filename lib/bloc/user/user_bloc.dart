import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/model/enitity/glucose_reading.dart';
import 'package:diabuddy/model/enitity/medication.dart';
import 'package:diabuddy/preferences/user_simple_preferences.dart';
import 'package:diabuddy/repository/dish_repository.dart';
import 'package:diabuddy/repository/glucose_repository.dart';
import 'package:diabuddy/repository/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final GlucoseRepository glucoseRepository;
  final DishRepository dishRepository;

  UserBloc({
    required this.glucoseRepository,
    required this.dishRepository,
    required this.userRepository,
  }) : super(InitialUserState()) {
    on<ProfileUpdateEvent>(_onUpdateProfile);
    on<AddMedicationEvent>(_onAddMedication);
    on<GetAllMedications>(_onFetchMedication);
    on<DeleteMedication>(_onDeleteMedication);
    on<GetGlucoseReadingsForPeriod>(_onFetchGlucoseReadingsToday);
    on<GetGlucoseTargets>(_onFetchGlucoseTargets);
    on<SaveGlucoseTargets>(_onSaveGlucoseTargets);
    on<SaveNewDish>(_onSaveNewDish);
    on<GetDishes>(_onFetchDishes);
    on<EditDish>(_onDishUpdate);
    on<GetAllGlucoseReadings>(_onFetchAllGlucoseReadings);
    on<GetGlucoseReadingById>(_onFetchGlucoseReading);
    on<UpdateGlucoseReading>(_onUpdateGlucoseReading);
    on<UpdateGlucoseReadingActivity>(_onUpdateGlucoseReadingActivity);
    on<GetGlucoseReadingDishes>(_onFetchGlucoseReadingMeal);
    on<DeleteDish>(_onDeleteGlucoseReadingDish);
    on<AddDishToGlucoseReading>(_onAddDishToGlucoseReading);
    on<GetUserProfileData>(_onFetchUserData);
    on<UpdateUserData>(_onUpdatePersonalUserData);
    on<CheckIfUserExists>(_onCheckIfUserExist);
    on<GetGlucoseReadingMedication>(_onFetchGlucoseReadingMedication);
    on<DeleteGlucoseReadingTherapy>(_onDeleteGlucoseReadingTherapy);
    on<AddTherapyToGlucoseReading>(_onAddTherapyToGlucoseReading);
    on<AddNewGlucoseReading>(_onAddNewGlucoseReading);
    on<DeleteMedicationNotifications>(_onDeleteMedicationNotifications);
    on<GetTodaysTherapyRecords>(_onFetchTherapyRecords);
    on<SaveTherapyRecord>(_onSaveTherapyRecords);
  }

  FutureOr<void> _onUpdateProfile(
    ProfileUpdateEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      await userRepository.updateAccountData(
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
      emit(SavedlMedication());
    } catch (_) {
      emit(SavingMedicationFailed());
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
      await userRepository.deleteMedicationNotifications(event.medicationId);
      emit(DeletedMedication());
    } catch (_) {
      emit(DeletingMedicationFailed());
    }
  }

  FutureOr<void> _onFetchGlucoseReadingsToday(
    GetGlucoseReadingsForPeriod event,
    Emitter<UserState> emit,
  ) async {
    try {
      List<GlucoseReading> readings = await glucoseRepository
          .fetchGlucoseReadingsByPeriod(start: event.start, end: event.end);
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
      await dishRepository.saveNewDish(event.dish);
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
      var dishes = await dishRepository.fetchDishes();
      emit(FetchedDishes(dishes));
    } catch (_) {
      emit(FetchedDishesFailed());
    }
  }

  FutureOr<void> _onDishUpdate(
    EditDish event,
    Emitter<UserState> emit,
  ) async {
    try {
      await dishRepository.updateDish(event.dish);
    } catch (_) {
      emit(DishUpdatedFailed());
    }
  }

  FutureOr<void> _onFetchAllGlucoseReadings(
    GetAllGlucoseReadings event,
    Emitter<UserState> emit,
  ) async {
    try {
      var glucoseReadings = await glucoseRepository.fetchAllGlucoseReadings();
      emit(FetchedAllGlucoseReadings(glucoseReadings));
    } catch (_) {
      emit(FetchedAllGlucoseReadingsFailed());
    }
  }

  FutureOr<void> _onFetchGlucoseReading(
    GetGlucoseReadingById event,
    Emitter<UserState> emit,
  ) async {
    try {
      var glucoseReading = await glucoseRepository
          .fetchGlucoseReadingById(event.glucoseReadingId);
      if (glucoseReading == null) {
        emit(FetchedAllGlucoseReadingsFailed());
      }
      var therapyForGlucoseReading = await glucoseRepository
          .fetchTherapyForGlucoseReading(event.glucoseReadingId);
      var dishesForGlucoseReading = await dishRepository
          .fetchGlucoseReadingDishes(glucoseReadingId: event.glucoseReadingId);
      emit(FetchedGlucoseReading(
          glucoseReading!, therapyForGlucoseReading, dishesForGlucoseReading));
    } catch (_) {
      emit(FetchedAllGlucoseReadingsFailed());
    }
  }

  FutureOr<void> _onUpdateGlucoseReading(
    UpdateGlucoseReading event,
    Emitter<UserState> emit,
  ) async {
    try {
      await glucoseRepository.updateGlucoseReading(
        glucoseReadingId: event.glucoseReadingId,
        glucoseTiming: event.glucoseTiming,
        glucoseLevel: event.glucoseLevel,
        mealType: event.mealType,
      );
      emit(SuccessfullyUpdatedGlucoseReading());
    } catch (_) {
      emit(UpdateGlucoseReadingFailed());
    }
  }

  FutureOr<void> _onUpdateGlucoseReadingActivity(
    UpdateGlucoseReadingActivity event,
    Emitter<UserState> emit,
  ) async {
    try {
      await glucoseRepository.updateGlucoseReadingActivity(
        glucoseReadingId: event.glucoseReadingId,
        activity: event.activity,
      );
      emit(UpdatedGlucoseReadingActivity());
    } catch (_) {
      emit(UpdateGlucoseReadingActivityFailed());
    }
  }

  FutureOr<void> _onFetchGlucoseReadingMeal(
    GetGlucoseReadingDishes event,
    Emitter<UserState> emit,
  ) async {
    try {
      var dishes = await dishRepository.fetchGlucoseReadingDishes(
        glucoseReadingId: event.glucoseReadingId,
      );
      if (dishes.isEmpty) {
        await glucoseRepository.changeGlucoseReadingMealTaken(
          glucoseReadingId: event.glucoseReadingId,
          mealTaken: false,
        );
      } else if (dishes.length == 1) {
        await glucoseRepository.changeGlucoseReadingMealTaken(
          glucoseReadingId: event.glucoseReadingId,
          mealTaken: true,
        );
      }
      emit(FetchedGlucoseReadingDishes(dishes));
    } catch (_) {
      emit(FetchedGlucoseReadingDishesFailed());
    }
  }

  FutureOr<void> _onDeleteGlucoseReadingDish(
    DeleteDish event,
    Emitter<UserState> emit,
  ) async {
    try {
      await dishRepository.deleteDishWithId(
        glucoseReadingId: event.glucoseReadingId,
        dishId: event.dishId,
      );
      var dishes = await dishRepository.fetchGlucoseReadingDishes(
        glucoseReadingId: event.glucoseReadingId,
      );
      emit(FetchedGlucoseReadingDishes(dishes));
    } catch (_) {
      emit(DeletingDishFailed());
    }
  }

  FutureOr<void> _onAddDishToGlucoseReading(
    AddDishToGlucoseReading event,
    Emitter<UserState> emit,
  ) async {
    try {
      await dishRepository.addDishToGlucoseReading(
        glucoseReadingId: event.glucoseReadingId,
        dish: event.dish,
      );
      emit(SavedGlucoseReadingDish());
    } catch (_) {
      emit(AddingDishToGlucoseReadingFailed());
    }
  }

  FutureOr<void> _onFetchUserData(
    GetUserProfileData event,
    Emitter<UserState> emit,
  ) async {
    try {
      var user = await userRepository.fetchUserData();
      if (user == null) {
        emit(FetchedUserDataFailed());
      } else {
        emit(FetchedUserData(user));
      }
    } catch (_) {
      emit(FetchedUserDataFailed());
    }
  }

  FutureOr<void> _onUpdatePersonalUserData(
    UpdateUserData event,
    Emitter<UserState> emit,
  ) async {
    try {
      await userRepository.updatePersonalUserData(
        weight: event.weight,
        fullName: event.fullName,
      );
      emit(UserProfileUpdateSuccessful());
    } catch (_) {
      emit(UserProfileUpdateFailed());
    }
  }

  FutureOr<void> _onCheckIfUserExist(
    CheckIfUserExists event,
    Emitter<UserState> emit,
  ) async {
    try {
      var user = await userRepository.fetchUserData();
      if (user == null) {
        emit(UserHasNoAccount());
      } else {
        if (user.weight == null) emit(UserSetupAccountNotFinished(1));
        if (user.glucoseTargets == null) emit(UserSetupAccountNotFinished(4));
      }
      var therapy = await userRepository.fetchMedication();
      if (therapy.isEmpty) {
        emit(UserSetupAccountNotFinished(2));
      }
      var isMeasurementSetup =
          UserSimplePreferences.isStandardMeasurementUnit() ?? false;
      if (!isMeasurementSetup) emit(UserSetupAccountNotFinished(3));
      emit(UserSetupAccountFinished());
    } catch (_) {
      emit(UserHasNoAccount());
    }
  }

  FutureOr<void> _onFetchGlucoseReadingMedication(
    GetGlucoseReadingMedication event,
    Emitter<UserState> emit,
  ) async {
    try {
      var data = await glucoseRepository
          .fetchTherapyForGlucoseReading(event.glucoseReadingId);
      emit(FetchedGlucoseReadingMedication(data));
      if (data.length == 1) {
        await glucoseRepository.changeGlucoseReadingMedicationTaken(
          glucoseReadingId: event.glucoseReadingId,
          medicationTaken: true,
        );
      } else if (data.isEmpty) {
        await glucoseRepository.changeGlucoseReadingMedicationTaken(
          glucoseReadingId: event.glucoseReadingId,
          medicationTaken: false,
        );
      }
    } catch (_) {
      emit(FetchedGlucoseReadingMedicationFailed());
    }
  }

  FutureOr<void> _onDeleteGlucoseReadingTherapy(
    DeleteGlucoseReadingTherapy event,
    Emitter<UserState> emit,
  ) async {
    try {
      await glucoseRepository.deleteGlucoseReadingTherapy(
        glucoseReadingId: event.glucoseReadingId,
        therapyId: event.therapyId,
      );
      var data = await glucoseRepository
          .fetchTherapyForGlucoseReading(event.glucoseReadingId);
      emit(FetchedGlucoseReadingMedication(data));
    } catch (_) {
      emit(FetchedGlucoseReadingMedicationFailed());
    }
  }

  FutureOr<void> _onAddTherapyToGlucoseReading(
    AddTherapyToGlucoseReading event,
    Emitter<UserState> emit,
  ) async {
    try {
      await glucoseRepository.saveTherapyToGlucoseReading(
        glucoseReadingId: event.glucoseReadingId,
        therapy: event.therapy,
      );
      emit(SavedGlucoseReadingTherapy());
    } catch (_) {
      emit(SavingGlucoseReadingTherapyFailed());
    }
  }

  FutureOr<void> _onAddNewGlucoseReading(
    AddNewGlucoseReading event,
    Emitter<UserState> emit,
  ) async {
    try {
      String glucoseReadingId = await glucoseRepository.addNewGlucoseReading(
          glucoseReading: event.glucoseReading);
      if (glucoseReadingId == '') {
        emit(SavingGlucoseReadingFailed());
      }
      emit(SavedGlucoseReading(glucoseReadingId));
    } catch (_) {
      emit(SavingGlucoseReadingFailed());
    }
  }

  FutureOr<void> _onDeleteMedicationNotifications(
    DeleteMedicationNotifications event,
    Emitter<UserState> emit,
  ) async {
    try {
      await userRepository.deleteMedicationNotifications(event.therapyId);
      emit(DeletedMedicationNotifications());
    } catch (_) {
      emit(DeletingMedicationNotificationsFailed());
    }
  }

  FutureOr<void> _onFetchTherapyRecords(
    GetTodaysTherapyRecords event,
    Emitter<UserState> emit,
  ) async {
    try {
      var records = await userRepository.fetchTherapyRecords();
      emit(FetchedTherapyRecords(records));
    } catch (_) {
      emit(FetchedTherapyRecordsFailed());
    }
  }

  FutureOr<void> _onSaveTherapyRecords(
    SaveTherapyRecord event,
    Emitter<UserState> emit,
  )async {
    try {
      await userRepository.saveTherapyRecords(record: event.record);
      emit(SavedTherapyRecord());
    } catch (_) {
      emit(SavingTherapyRecordFailed());
    }
  }
}
