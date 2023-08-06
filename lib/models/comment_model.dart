import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  CommentModel({
    required this.commentId,
    required this.uid,
    required this.text,
    this.profileUrl,
    required this.userName,
    required this.dateAdded,
    required this.postId,
  });

  String commentId;
  String uid;
  String text;
  String? profileUrl;
  String userName;
  Timestamp dateAdded;
  String postId;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        commentId: json["commentId"],
        text: json["text"],
        uid: json["uid"],
        profileUrl: json["profileUrl"],
        userName: json["userName"],
        dateAdded: json["dateAdded"],
        postId: json["postId"],
      );

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "uid": uid,
        "text": text,
        "profileUrl": profileUrl,
        "userName": userName,
        "dateAdded": dateAdded,
        "postId": postId,
      };
}
