import 'dart:developer';

import 'package:flutter/material.dart';

import '../../models/chat_model.dart';
import '../../models/message_model.dart';
import '../repo/chat_repo.dart';

class ChatController extends ChangeNotifier {
  final _repo = ChatRepo();
  Future<void> sendMessage({required MessageModel message}) async {
    try {
      await _repo.sendMessage(message: message);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> createChat(
      {required ChatModel chatModel, required MessageModel message}) async {
    try {
      await _repo.createChat(chatModel: chatModel, message: message);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
