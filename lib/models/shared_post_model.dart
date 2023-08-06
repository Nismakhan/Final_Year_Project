import 'package:cloud_firestore/cloud_firestore.dart';

class SharedPostModel {
  SharedPostModel({
    required this.docId,
    required this.postId,
    required this.uid,
    required this.name,
    this.profilePic,
    required this.dateSharedAt,
  });

  String docId;
  String postId;
  String uid;
  String name;
  String? profilePic;
  Timestamp dateSharedAt;

  factory SharedPostModel.fromJson(Map<String, dynamic> json) =>
      SharedPostModel(
        docId: json["docId"],
        postId: json["postId"],
        uid: json["uid"],
        name: json["name"],
        profilePic: json["profilePic"],
        dateSharedAt: json["dateSharedAt"],
      );

  Map<String, dynamic> toJson() => {
        "docId": docId,
        "postId": postId,
        "uid": uid,
        "name": name,
        "profilePic": profilePic,
        "dateSharedAt": dateSharedAt,
      };
}
