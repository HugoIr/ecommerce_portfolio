part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignUpWithEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  SignUpWithEmailPasswordEvent({required this.email, required this.password});
}

class SignInWithEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  SignInWithEmailPasswordEvent({required this.email, required this.password});
}
