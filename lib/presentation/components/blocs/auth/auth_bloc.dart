import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:funesia_clone/services/auth/auth_service.dart';
import 'package:funesia_clone/services/user/user_service.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthService authService;
  UserService userService;

  AuthBloc({required this.authService, required this.userService})
      : super(AuthInitial()) {
    on<SignUpWithEmailPasswordEvent>(_onSignUpWithEmailPassword);
    on<SignInWithEmailPasswordEvent>(_onSignInWithEmailPassword);
  }

  FutureOr<void> _onSignUpWithEmailPassword(
      SignUpWithEmailPasswordEvent event, Emitter<AuthState> emit) async {
    final result =
        await authService.signUpWithEmailPassword(event.email, event.password);
    print("_onSignUpWithEmailPassword");
    result.fold((failure) => print("Failed to signUp ${failure.message}"),
        (userCredential) {
      userService.addNewUser(
          userCredential.user!.uid, userCredential.user!.email!);
      emit(LoggedInState(userCredential: userCredential));
    });
  }

  FutureOr<void> _onSignInWithEmailPassword(
      SignInWithEmailPasswordEvent event, Emitter<AuthState> emit) async {
    final result = await authService.signIn(event.email, event.password);
    print("_onSignInWithEmailPassword");
    result.fold(
        (failure) => print("Failed to signIn ${failure.message}"),
        (userCredential) =>
            emit(LoggedInState(userCredential: userCredential)));
  }
}
