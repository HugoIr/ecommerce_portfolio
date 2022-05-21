part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final bool isSeller;
  UserLoaded({required this.isSeller});
}
