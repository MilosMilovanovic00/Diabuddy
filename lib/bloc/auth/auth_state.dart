abstract class AuthState {}

abstract class FailedAuthState extends AuthState{
  final Exception? exception;

  FailedAuthState({this.exception});
}

class InitialAuthState extends AuthState {}

class LoginFailed extends FailedAuthState {}

class LoginSuccessful extends AuthState {}

class RegistrationFailed extends FailedAuthState {}

class RegistrationSuccessful extends AuthState {}
