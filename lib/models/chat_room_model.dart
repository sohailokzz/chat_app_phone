class ChatRoomModel {
  String? chatRoomId;
  Map<String, dynamic>? participant;
  String? lastMessage;

  ChatRoomModel({
    this.chatRoomId,
    this.participant,
    this.lastMessage,
  });

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatRoomId = map["chatRoomId"];
    participant = map["participant"];
    lastMessage = map["lastMessage"];
  }

  Map<String, dynamic> toMap() {
    return {
      "chatRoomId": chatRoomId,
      "participant": participant,
      "lastMessage": lastMessage,
    };
  }
}
