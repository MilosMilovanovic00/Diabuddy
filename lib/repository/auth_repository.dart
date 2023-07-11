import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/model/enitity/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => postDetailsToFirestore(fullName));
    } on FirebaseFirestore catch (e) {}
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  postDetailsToFirestore(String fullName) async {
    if (currentUser != null) {
      UserModel user = UserModel(
        uid: currentUser!.uid,
        fullName: fullName,
        email: currentUser!.email,
      );
      await _firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .set(user.toMap());
    }
  }
}
