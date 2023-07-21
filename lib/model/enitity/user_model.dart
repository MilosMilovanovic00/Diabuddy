import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? uid;
  final String? fullName;
  final String? email;
  final DateTime? dateOfBirth;
  final int? weight;
  final GlucoseTargets? glucoseTargets;

  const UserModel({
    this.dateOfBirth,
    this.weight,
    this.uid,
    this.fullName,
    this.email,
    this.glucoseTargets,
  });

  @override
  List<Object?> get props =>
      [uid, fullName, email, dateOfBirth, weight, glucoseTargets];

  // ovo nam treba da konvertujemo sa firebase u aplikaciju
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      fullName: map['fullName'],
      email: map['email'],
      dateOfBirth: map['dateOfBirth'],
      weight: map['weight'],
      glucoseTargets: GlucoseTargets.fromMap(map['glucoseTargets']),
    );
  }

  // ovo name treba da posaljemo podatke kao mapa
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'weight': weight,
      'dateOfBirth': dateOfBirth,
      'glucoseTargets': glucoseTargets?.toMap()
    };
  }
}

class GlucoseTargets {
  final double afterMeal;
  final double beforeMeal;
  final double criticalHigh;
  final double criticalLow;
  final double low;

  GlucoseTargets({
    required this.afterMeal,
    required this.beforeMeal,
    required this.criticalHigh,
    required this.criticalLow,
    required this.low,
  });

  factory GlucoseTargets.fromMap(map) {
    return GlucoseTargets(
      afterMeal: map['afterMeal'],
      beforeMeal: map['beforeMeal'],
      criticalHigh: map['criticalHigh'],
      criticalLow: map['criticalLow'],
      low: map['low'],
    );
  }

  // ovo name treba da posaljemo podatke kao mapa
  Map<String, dynamic> toMap() {
    return {
      'criticalLow': criticalLow,
      'criticalHigh': criticalHigh,
      'beforeMeal': beforeMeal,
      'afterMeal': afterMeal,
      'low': low,
    };
  }
}
