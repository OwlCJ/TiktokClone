import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/models/messages_model.dart';

class MessagesRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendMessage(MessagesModel message) async {
    await _db
        .collection("chat_rooms")
        .doc("7fcE8hHUDtog85hXdMQ2")
        .collection("texts")
        .add(message.toJson());
  }
}

final messagesRepo = Provider((ref) => MessagesRepo());
