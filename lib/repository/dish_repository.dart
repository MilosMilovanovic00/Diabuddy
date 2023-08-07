import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/model/enitity/dish.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DishRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> saveNewDish(Dish dish) async {
    try {
      if (currentUser != null) {
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('meals')
            .add(
              dish.toMap(),
            );
      }
    } on FirebaseException catch (e) {
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

  Future<void> updateDish(Dish dish) async {
    try {
      if (currentUser != null) {
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('meals')
            .doc(dish.id)
            .update(
              dish.toMap(),
            );
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<List<Dish>> fetchGlucoseReadingDishes({
    required String glucoseReadingId,
  }) async {
    List<Dish> dishes = [];
    if (currentUser != null) {
      var data = await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('glucose_readings')
          .doc(glucoseReadingId)
          .collection('dishes')
          .get();
      if (data.docs.isEmpty) return dishes;
      for (var element in data.docs) {
        dishes.add(Dish.fromMap(element.data(), element.id));
      }
    }
    return dishes;
  }

  Future<void> deleteDishWithId({
    required String glucoseReadingId,
    required String dishId,
  }) async {
    try {
      if (currentUser != null) {
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('glucose_readings')
            .doc(glucoseReadingId)
            .collection('dishes')
            .doc(dishId)
            .delete();
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<void> addDishToGlucoseReading({
    required String glucoseReadingId,
    required Dish dish,
  }) async {
    try {
      if (currentUser != null) {
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .collection('glucose_readings')
            .doc(glucoseReadingId)
            .collection('dishes')
            .add(dish.toMap());
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }
}
