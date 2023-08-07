import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:diabuddy/bloc/auth/auth_event.dart';
import 'package:diabuddy/bloc/auth/auth_state.dart';
import 'package:diabuddy/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(InitialAuthState()) {
    on<LoginEvent>(_onLogin);
    on<RegistrationEvent>(_onRegister);
  }

  FutureOr<void> _onLogin(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) {
    try {
      authRepository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccessful());
    } catch (_) {
      emit(LoginFailed());
    }
  }

  FutureOr<void> _onRegister(
    RegistrationEvent event,
    Emitter<AuthState> emit,
  ) {
    try {
      authRepository.createUserWithEmailAndPassword(
        fullName: event.fullName,
        email: event.email,
        password: event.password,
      );
      emit(RegistrationSuccessful());
    } catch (_) {
      emit(RegistrationFailed());
    }
  }
}
