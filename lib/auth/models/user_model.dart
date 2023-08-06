import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String name;
  String email;
  String? organization;
  String? profileUrl;
  String? contactNumber;
  String? type;
  String? uniqueId;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.organization,
    this.profileUrl,
    this.contactNumber,
    this.type,
    this.uniqueId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      organization: json["organization"],
      profileUrl: json["profileUrl"],
      contactNumber: json["contactNumber"],
      type: json["type"],
      uniqueId: json["uniqueId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "organization": organization,
      "profileUrl": profileUrl,
      "contactNumber": contactNumber,
      "type": type,
      "uniqueId": uniqueId,
    };
  }
}
