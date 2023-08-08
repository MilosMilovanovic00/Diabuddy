import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/model/enitity/medication.dart';
import 'package:diabuddy/model/enitity/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> updateAccountData({
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
    } on FirebaseException catch (e) {
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
    } on FirebaseException catch (e) {
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
    } on FirebaseException catch (e) {
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
    } on FirebaseException catch (e) {
      print(e.toString());
    }
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
    } on FirebaseException catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<UserModel?> fetchUserData() async {
    try {
      if (currentUser != null) {
        var data =
            await _firestore.collection('users').doc(currentUser!.uid).get();
        UserModel user = UserModel.fromMap(data.data(),currentUser!.uid);
        return user;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<void> updatePersonalUserData({
    required int weight,
    required String fullName,
  }) async {
    try {
      if (currentUser != null) {
        await _firestore.collection('users').doc(currentUser!.uid).update({
          "weight": weight,
          "fullName": fullName,
        });
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }
}
