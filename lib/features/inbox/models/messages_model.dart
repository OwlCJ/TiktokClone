class MessagesModel {
  final String text;
  final String uid;
  final int createdAt;

  MessagesModel({
    required this.text,
    required this.uid,
    required this.createdAt,
  });

  MessagesModel.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        createdAt = json['createdAt'],
        uid = json['uid'];

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "createdAt": createdAt,
      "uid": uid,
    };
  }
}
