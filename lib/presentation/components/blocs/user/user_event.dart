part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetUserInformationEvent extends UserEvent {}

class BecomeSellerEvent extends UserEvent {}
