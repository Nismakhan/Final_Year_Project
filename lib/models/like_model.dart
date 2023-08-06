import 'package:cloud_firestore/cloud_firestore.dart';

class LikeModel {
  LikeModel({
    required this.likeId,
    required this.uid,
    this.profileUrl,
    required this.userName,
    required this.dateAdded,
    required this.postId,
  });

  String likeId;
  String uid;
  String? profileUrl;
  String userName;
  Timestamp dateAdded;
  String postId;

  factory LikeModel.fromJson(Map<String, dynamic> json) => LikeModel(
        likeId: json["commentId"],
        uid: json["uid"],
        profileUrl: json["profileUrl"],
        userName: json["userName"],
        dateAdded: json["dateAdded"],
        postId: json["postId"],
      );

  Map<String, dynamic> toJson() => {
        "commentId": likeId,
        "uid": uid,
        "profileUrl": profileUrl,
        "userName": userName,
        "dateAdded": dateAdded,
        "postId": postId,
      };
}
