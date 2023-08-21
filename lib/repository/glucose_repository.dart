import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/model/activity.dart';
import 'package:diabuddy/model/enitity/enum/glucose_type.dart';
import 'package:diabuddy/model/enitity/enum/meal_type.dart';
import 'package:diabuddy/model/enitity/glucose_reading.dart';
import 'package:diabuddy/model/enitity/therapy.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GlucoseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<List<GlucoseReading>> fetchGlucoseReadingsByPeriod({
    required DateTime start,
    required DateTime end,
  }) async {
    List<GlucoseReading> readings = [];
    if (currentUser != null) {
      var data = await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('glucose_readings')
          .where("entryTime", isGreaterThanOrEqualTo: start, isLessThan: end)
          .get();
      if (data.docs.isEmpty) return readings;
      for (var element in data.docs) {
        readings.add(GlucoseReading.fromMap(element.data(), element.id));
      }
    }
    return readings;
  }

  Future<List<GlucoseReading>> fetchAllGlucoseReadings() async {
    List<GlucoseReading> readings = [];
    if (currentUser != null) {
      var data = await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('glucose_readings')
          .get();
      if (data.docs.isEmpty) return readings;
      for (var element in data.docs) {
        readings.add(GlucoseReading.fromMap(
          element.data(),
          element.id,
        ));
      }
    }
    return readings;
  }

  Future<GlucoseReading?> fetchGlucoseReadingById(String id) async {
    try {
      if (currentUser != null) {
        var data = await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('glucose_readings')
            .doc(id)
            .get();
        if (!data.exists) {
          return null;
        } else {
          return GlucoseReading.fromMap(data.data(), data.id);
        }
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<Therapy>> fetchTherapyForGlucoseReading(
    String glucoseReadingId,
  ) async {
    List<Therapy> therapy = [];
    if (currentUser != null) {
      var data = await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('glucose_readings')
          .doc(glucoseReadingId)
          .collection('therapy')
          .get();
      if (data.docs.isEmpty) return therapy;
      for (var element in data.docs) {
        therapy.add(Therapy.fromMap(element.data(), element.id));
      }
    }
    return therapy;
  }

  Future<void> updateGlucoseReading({
    required String glucoseReadingId,
    required GlucoseTiming glucoseTiming,
    required double glucoseLevel,
    MealType? mealType,
  }) async {
    try {
      if (currentUser != null) {
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('glucose_readings')
            .doc(glucoseReadingId)
            .update({
          'glucoseTiming': glucoseTiming.index,
          'glucoseValue': glucoseLevel,
          'mealType': mealType!.index,
        });
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateGlucoseReadingActivity({
    required String glucoseReadingId,
    required Activity activity,
  }) async {
    try {
      if (currentUser != null) {
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('glucose_readings')
            .doc(glucoseReadingId)
            .update({
          'activity': activity.toMap(),
        });
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteGlucoseReadingTherapy({
    required String glucoseReadingId,
    required String therapyId,
  }) async {
    try {
      if (currentUser != null) {
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('glucose_readings')
            .doc(glucoseReadingId)
            .collection('therapy')
            .doc(therapyId)
            .delete();
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<void> saveTherapyToGlucoseReading({
    required String glucoseReadingId,
    required Therapy therapy,
  }) async {
    try {
      if (currentUser != null) {
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('glucose_readings')
            .doc(glucoseReadingId)
            .collection('therapy')
            .add(therapy.toMap());
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<String> addNewGlucoseReading({
    required GlucoseReading glucoseReading,
  }) async {
    try {
      String glucoseReadingId = '';
      if (currentUser != null) {
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('glucose_readings')
            .add(glucoseReading.toMap())
            .then((value) => glucoseReadingId = value.id);
      }
      return glucoseReadingId;
    } on FirebaseException catch (e) {
      print(e.toString());
      return '';
    }
  }

  Future<void> changeGlucoseReadingMealTaken({
    required String glucoseReadingId,
    required bool mealTaken,
  }) async {
    try {
      if (currentUser != null) {
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('glucose_readings')
            .doc(glucoseReadingId)
            .update({'mealTaken': mealTaken});
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<void> changeGlucoseReadingMedicationTaken({
    required String glucoseReadingId,
    required bool medicationTaken,
  }) async {
    try {
      if (currentUser != null) {
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('glucose_readings')
            .doc(glucoseReadingId)
            .update({'medicationTaken': medicationTaken});
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }
}
