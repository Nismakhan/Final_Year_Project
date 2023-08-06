import 'package:cloud_firestore/cloud_firestore.dart';

class FollowModel {
  String uid;
  String userName;
  String? profileUrl;
  Timestamp dateAdded;

  FollowModel({
    required this.uid,
    this.profileUrl,
    required this.userName,
    required this.dateAdded,
  });

  factory FollowModel.fromJson(Map<String, dynamic> json) => FollowModel(
        uid: json["uid"],
        profileUrl: json["profileUrl"],
        userName: json["userName"],
        dateAdded: json["dateAdded"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "profileUrl": profileUrl,
        "userName": userName,
        "dateAdded": dateAdded,
      };
}
