import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/model/enitity/medication.dart';
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
            .doc("PACWVFLoSkhN3sBjMqWEhWOqMUx1")
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
        medicine.add(Medication.fromMap(element.data(),element.id));
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
}
