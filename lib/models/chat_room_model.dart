class ChatRoomModel {
  String? chatRoomId;
  List<String>? participant;

  ChatRoomModel({
    this.chatRoomId,
    this.participant,
  });

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatRoomId = map["chatRoomId"];
    participant = map["participant"];
  }

  Map<String, dynamic> toMap() {
    return {
      "chatRoomId": chatRoomId,
      "participant": participant,
    };
  }
}
