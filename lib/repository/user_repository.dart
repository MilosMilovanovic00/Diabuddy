import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/model/enitity/dish.dart';
import 'package:diabuddy/model/enitity/glucose_reading.dart';
import 'package:diabuddy/model/enitity/medication.dart';
import 'package:diabuddy/model/enitity/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> updatePersonalData({
    required int weight,
    required DateTime dateOfBirth,
  }) async {
    try {
      if (currentUser != null) {
        await _firestore.collection('users').doc(currentUser!.uid).update({
          'weight': weight,
          'dateOfBirth': dateOfBirth,
        });
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  Future<void> addMedication({required Medication medication}) async {
    try {
      if (currentUser != null) {
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('medicine')
            .add(
              medication.toMap(),
            );
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  Future<List<Medication>> fetchMedication() async {
    List<Medication> medicine = [];
    if (currentUser != null) {
      var data = await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('medicine')
          .get();
      if (data.docs.isEmpty) return medicine;
      for (var element in data.docs) {
        medicine.add(Medication.fromMap(element.data(), element.id));
      }
    }
    return medicine;
  }

  Future<void> deleteMedication(String medicationId) async {
    try {
      if (currentUser != null) {
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('medicine')
            .doc(medicationId)
            .delete();
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  Future<void> saveGlucoseTargets(
    GlucoseTargets glucoseTargets,
  ) async {
    try {
      if (currentUser != null) {
        await _firestore.collection('users').doc(currentUser!.uid).update({
          'glucoseTargets': glucoseTargets.toMap(),
        });
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  Future<List<GlucoseReading>> fetchTodaysGlucoseReadings() async {
    List<GlucoseReading> readings = [];
    if (currentUser != null) {
      var data = await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('glucose_readings')
          .where("entryTime", isEqualTo: DateTime.now())
          .get();
      if (data.docs.isEmpty) return readings;
      for (var element in data.docs) {
        readings.add(GlucoseReading.fromMap(element.data(), element.id));
      }
    }
    return readings;
  }

  Future<GlucoseTargets?> fetchGlucoseTargets() async {
    try {
      if (currentUser != null) {
        var data =
            await _firestore.collection('users').doc(currentUser!.uid).get();
        GlucoseTargets glucoseTargets =
            GlucoseTargets.fromMap(data.get('glucoseTargets'));
        return glucoseTargets;
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<void> saveNewDish(Dish dish) async {
    try {
      await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('meals')
          .add(
            dish.toMap(),
          );
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  Future<List<Dish>> fetchDishes() async {
    List<Dish> dishes = [];
    if (currentUser != null) {
      var data = await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('meals')
          .get();
      if (data.docs.isEmpty) return dishes;
      for (var element in data.docs) {
        dishes.add(Dish.fromMap(element.data(), element.id));
      }
    }
    return dishes;
  }
}
