import 'package:cloud_firestore/cloud_firestore.dart';

class UserPosts {
  UserPosts({
    required this.postId,
    required this.uid,
    required this.name,
    this.profilePicture,
    this.userPostsAsset,
    this.about,
    required this.likesCount,
    required this.commentsCount,
    required this.shareCount,
    required this.lastLikes,
    required this.dateAdded,
    this.uniqueId,
  });

  String postId;
  String uid;
  String name;
  String? profilePicture;
  String? userPostsAsset;
  String? about;
  int likesCount;
  int commentsCount;
  int shareCount;
  String? uniqueId;
  Timestamp dateAdded;
  List<Map<String, dynamic>> lastLikes;

  factory UserPosts.fromJson(Map<String, dynamic> json) => UserPosts(
        postId: json["postId"] ?? "",
        uid: json["uid"] ?? "",
        name: json["name"],
        profilePicture: json["profilePicture"] ?? '',
        userPostsAsset: json["userPostsAsset"],
        about: json["about"],
        dateAdded: json["dateAdded"],
        uniqueId: json["uniqueId"],
        likesCount: (json["likesCount"] == null) ? 0 : json["likesCount"],
        shareCount: (json["shareCount"] == null) ? 0 : json["shareCount"],
        commentsCount:
            (json["commentsCount"] == null) ? 0 : json["commentsCount"],
        lastLikes: (json["lastLikes"] == null)
            ? []
            : (json["lastLikes"] as List)
                .map((e) => e as Map<String, dynamic>)
                .toList(),
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "uid": uid,
        "name": name,
        "profilePicture": profilePicture,
        "userPostsAsset": userPostsAsset,
        "about": about,
        "dateAdded": dateAdded,
        "likesCount": likesCount,
        "shareCount": shareCount,
        "commentsCount": commentsCount,
        "lastLikes": lastLikes,
        "uniqueId": uniqueId,
      };
}
