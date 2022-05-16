import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:funesia_clone/data/model/remote/chat/chat_channel.dart';
import 'package:funesia_clone/data/model/remote/chat/chat_message.dart';
import 'package:funesia_clone/services/user/user_service.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  UserService userService;
  ChatBloc({required this.userService}) : super(ChatInitial()) {
    on<SetupChatEvent>(_onSetupChannel);
    on<SendChatEvent>(_onSendChat);
  }
  void _onSetupChannel(SetupChatEvent event, Emitter<ChatState> emit) async {
    print("onSETUP CHANNEl");
    ChatChannel chatChannel = await userService.setupChannel(event.idTo);
    emit(ChatLoaded(
      idTo: event.idTo,
      chatChannel: chatChannel,
    ));
  }

  void _onSendChat(SendChatEvent event, Emitter<ChatState> emit) async {
    final state = this.state;
    if (state is ChatLoaded) {
      print("dlm onsendchat");
      ChatMessage message = await userService.sendMessage(
          state.chatChannel.id!, state.idTo, event.content, event.type);
      ChatChannel newChatChannel = state.chatChannel;
      newChatChannel.messages.add(message.toJson());
      emit(ChatLoaded(idTo: state.idTo, chatChannel: newChatChannel));
    }
  }
}
