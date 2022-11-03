class MessageModel {
  String? messageId;
  String? sender;
  String? text;
  bool? seen;
  DateTime? createDone;

  MessageModel({
    this.messageId,
    this.sender,
    this.text,
    this.seen,
    this.createDone,
  });

  MessageModel.fromMap(Map<String, dynamic> map) {
    sender = map["sender"];
    text = map["text"];
    seen = map["seen"];
    createDone = map["createDone"];
    messageId = map["messageId"];
  }

  Map<String, dynamic> toMap() {
    return {
      "sender": sender,
      "text": text,
      "seen": seen,
      "createDone": createDone,
      "messageId": messageId,
    };
  }
}
