import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/model/enitity/medication.dart';
import 'package:diabuddy/model/enitity/user_model.dart';
import 'package:diabuddy/model/grouped_therapy_record.dart';
import 'package:diabuddy/model/therapy_record.dart';
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
        UserModel user = UserModel.fromMap(data.data(), currentUser!.uid);
        return user;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
    return null;
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

  Future<void> deleteMedicationNotifications(
    String medicationId,
  ) async {
    try {
      if (currentUser != null) {
        var data = await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('notifications')
            .where('therapyId', isEqualTo: medicationId)
            .get();
        for (var element in data.docs) {
          await _firestore
              .collection('users')
              .doc(currentUser!.uid)
              .collection('notifications')
              .doc(element.id)
              .delete();
        }
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<List<GroupedTherapyRecord>> fetchTherapyRecords() async {
    Map<String, GroupedTherapyRecord> record = {};
    List<TherapyRecord> records = [];

    DateTime now = DateTime.now();
    DateTime start = DateTime(now.year, now.month, now.day);
    DateTime end = start.add(const Duration(days: 1));
    if (currentUser != null) {
      var data = await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('therapyRecords')
          .where('time', isGreaterThanOrEqualTo: start, isLessThan: end)
          .get();
      if (data.docs.isEmpty) return [];
      for (var element in data.docs) {
        records.add(TherapyRecord.fromMap(element.data()));
      }
      for (var element in records) {
        if (!record.containsKey(element.therapyName)) {
          record[element.therapyName] = GroupedTherapyRecord(
            therapyName: element.therapyName,
            isInsulin: element.isInsulin,
            count: 1,
          );
        } else {
          record[element.therapyName]!.incrementCount();
        }
      }
    }
    return record.values.toList();
  }

  Future<void> saveTherapyRecords({
    required TherapyRecord record,
  }) async {
    try {
      if (currentUser != null) {
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('therapyRecords')
            .add(record.toMap());
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }
}
