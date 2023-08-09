import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/chat_model.dart';
import '../../models/message_model.dart';

class ChatRepo {
  final _firestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;
  Future<void> sendMessage({required MessageModel message}) async {
    try {
      await _firestore
          .collection("chats")
          .doc(message.chatId)
          .collection("messages")
          .doc(message.messageId)
          .set(message.toJson());

      await _firestore.collection("chats").doc(message.chatId).update(
        {
          "lastMessage": message.toJson(),
          "dateModified": Timestamp.now(),
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createChat(
      {required ChatModel chatModel, required MessageModel message}) async {
    try {
      await _firestore
          .collection("chats")
          .doc(chatModel.chatId)
          .set(chatModel.toJson());

      await _firestore
          .collection("chats")
          .doc(chatModel.chatId)
          .collection("messages")
          .doc(message.messageId)
          .set(message.toJson());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
