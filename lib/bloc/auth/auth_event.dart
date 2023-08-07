import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class RegistrationEvent extends AuthEvent {
  final String fullName;
  final String email;
  final String password;

  RegistrationEvent({
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [fullName, email, password];
}
