import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/auth/models/user_model.dart';


class NotificationModel {
  final String title;
  final String body;
  final String notificationId;
  final String uid;
  final Timestamp time;
  final String image;
  final UserModel user;

  NotificationModel({
    required this.user,
    required this.time,
    required this.title,
    required this.uid,
    required this.body,
    required this.notificationId,
    required this.image,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      user: UserModel.fromJson(json["user"]),
      uid: json["uid"],
      time: json["time"],
      image: json["image"],
      title: json["title"],
      body: json["body"],
      notificationId: json["notificationId"],
    );
  }
  Map<String, dynamic> json() {
    return {
      "user": user.toJson(),
      "image": image,
      "time": time,
      "uid": uid,
      "title": title,
      "body": body,
      "notificationId": notificationId,
    };
  }
}
