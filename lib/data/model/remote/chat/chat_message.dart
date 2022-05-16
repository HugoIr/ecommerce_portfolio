class ChatMessage {
  String idFrom;
  String idTo;
  dynamic content;
  int type;
  String timestamp;

  ChatMessage(
      {required this.idFrom,
      required this.idTo,
      required this.content,
      required this.type,
      required this.timestamp});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      idFrom: json["idFrom"],
      idTo: json["idTo"],
      content: json["content"],
      type: json["type"],
      timestamp: json["timestamp"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idFrom": idFrom,
      "idTo": idTo,
      "content": content,
      "type": type,
      "timestamp": timestamp,
    };
  }
}
