import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/model/app_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> addNotification({
    required AppNotification notification,
  }) async {
    try {
      if (currentUser != null) {
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('notifications')
            .add(
              notification.toMap(),
            );
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteNotification({
    required String notificationId,
  }) async {
    try {
      if (currentUser != null) {
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('notifications')
            .doc(notificationId)
            .delete();
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<List<AppNotification>> fetchNotification() async {
    try {
      List<AppNotification> list = [];
      if (currentUser != null) {
        final data = await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('notifications')
            .get();
        for (var elem in data.docs) {
          list.add(AppNotification.fromMap(elem.data(), elem.id));
        }
      }
      return list;
    } on FirebaseException catch (e) {
      print(e.toString());
    }
    return [];
  }

  Future<List<AppNotification>> fetchNotificationForTherapy({
    required String therapyId,
  }) async {
    try {
      List<AppNotification> list = [];
      if (currentUser != null) {
        final data = await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('notifications')
            .where('therapyId', isEqualTo: therapyId)
            .get();
        for (var elem in data.docs) {
          list.add(AppNotification.fromMap(elem.data(), elem.id));
        }
      }
      return list;
    } on FirebaseException catch (e) {
      print(e.toString());
    }
    return [];
  }
}
