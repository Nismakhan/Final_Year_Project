class UserModel {
  String uid;
  String name;
  String email;
  String? organization;
  String? profileUrl;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.organization,
    this.profileUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      organization: json["organization"],
      profileUrl: json["profileUrl"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "organization": organization,
      "profileUrl": profileUrl,
    };
  }
}
