part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class SetupChatEvent extends ChatEvent {
  final String idTo;
  SetupChatEvent({required this.idTo});
}

class SendChatEvent extends ChatEvent {
  final dynamic content;
  final int type;
  SendChatEvent({required this.content, required this.type});
}
