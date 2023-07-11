import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? uid;
  final String? fullName;
  final String? email;
  final DateTime? dateOfBirth;
  final int? weight;

  const UserModel({
    this.dateOfBirth,
    this.weight,
    this.uid,
    this.fullName,
    this.email,
  });

  @override
  List<Object?> get props => [uid, fullName, email, dateOfBirth, weight];

  // ovo nam treba da konvertujemo sa firebase u aplikaciju
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      fullName: map['fullName'],
      email: map['email'],
      dateOfBirth: map['dateOfBirth'],
      weight: map['weight'],
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
    };
  }
}
