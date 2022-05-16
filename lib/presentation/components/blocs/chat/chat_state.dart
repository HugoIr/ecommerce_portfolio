part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoaded extends ChatState {
  final ChatChannel chatChannel;
  final String idTo;
  ChatLoaded({
    required this.idTo,
    required this.chatChannel,
  });
}
