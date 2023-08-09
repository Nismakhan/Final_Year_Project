import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  MessageModel({
    required this.messageId,
    required this.chatId,
    required this.uid,
    required this.text,
    required this.dateAdded,
  });

  String messageId;
  String chatId;
  String uid;
  String text;
  Timestamp dateAdded;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        messageId: json["messageId"],
        chatId: json["chatId"],
        uid: json["uid"],
        text: json["text"],
        dateAdded: json["dateAdded"],
      );

  Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "chatId": chatId,
        "uid": uid,
        "text": text,
        "dateAdded": dateAdded,
      };
}
