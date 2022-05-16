import 'package:funesia_clone/data/model/remote/chat/chat_message.dart';

class ChatChannel {
  String? id;
  List<dynamic> usersId;
  List<dynamic> messages;

  ChatChannel({this.id, required this.usersId, required this.messages});

  factory ChatChannel.fromJson(Map<String, dynamic> json) {
    return ChatChannel(
      usersId: json["usersId"],
      // messages: json["messages"].map((val) {
      //   print("VALLL $val");
      //   return ChatMessage.fromJson(val);
      // }),
      messages: json["messages"],
    );
  }

  Map<String, dynamic> toJson(ChatChannel chatChannel) {
    return {
      "usersId": chatChannel.usersId,
      "messages": chatChannel.messages,
    };
  }
}
