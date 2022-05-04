part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoggedInState extends AuthInitial {
  final UserCredential userCredential;

  LoggedInState({required this.userCredential});
}
