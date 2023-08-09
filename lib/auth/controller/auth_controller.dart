import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/auth/db/database.dart';
import 'package:final_year_project/auth/models/user_model.dart';
import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/common/helper.dart';
import 'package:final_year_project/models/follow_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/chat_model.dart';

class AuthController extends ChangeNotifier {
  UserModel? appUser;
  final AuthBD _db = AuthBD();
  bool isloading = false;

  loading() {
    isloading = !isloading;
    notifyListeners();
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      appUser = await _db.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required UserModel user,
    required String password,
  }) async {
    try {
      final credentials = await _db.signUpWithEmailAndPassword(
        user: user,
        password: password,
      );
      appUser = user;
      notifyListeners();

      log("new current user: ${appUser?.toJson().toString()}");
    } catch (e) {
      print("error in controller $e");
    }
  }

  Future<User?> checkCurrentUser(BuildContext context) async {
    try {
      final currentUser = _db.isCurrentUser();
      if (currentUser != null) {
        appUser = await _db.getUserById(currentUser.uid);
        log(appUser!.toJson().toString());
        //notifyListeners();
        return currentUser;
      } else {
        Navigator.pushReplacementNamed(context, AppRouter.login);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  XFile? pickedImage;
  void changeImage({required XFile? image}) {
    pickedImage = image;
    uploadProfileImage();
  }

  void removeImage() {
    pickedImage = null;
    notifyListeners();
  }

  bool isUploading = false;

  Future<void> uploadProfileImage() async {
    try {
      isUploading = true;
      notifyListeners();
      if (pickedImage != null) {
        if (appUser!.profileUrl != null) {
          await Helper.deleteImage(url: appUser!.profileUrl!);
          appUser!.profileUrl = null;
        }
        final url = await Helper.uploadImage(
            id: appUser!.uid,
            file: pickedImage!,
            ref: "users/${appUser!.uid}/${pickedImage!.name}");

        appUser!.profileUrl = url;
        await _db.updateUser(user: appUser!);
        isUploading = false;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserById({required String uid}) async {
    try {
      return await _db.getUserById(uid);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> followUser({required FollowModel followModel}) async {
    try {
      final myFollowModel = FollowModel(
          uid: appUser!.uid,
          userName: appUser!.name,
          profileUrl: appUser!.profileUrl,
          dateAdded: Timestamp.now());
      await _db.followUser(
          myFollowModel: myFollowModel, followModel: followModel);
      log("Followed");
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> unFollow({required String uid}) async {
    try {
      await _db.unFollow(uid: uid);
      log("UnFollowed");
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> removeFollower({required String uid}) async {
    try {
      await _db.removeFollower(uid: uid);
      log("Follower Removed");
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<bool> isUserFollowed({required String uid}) async {
    try {
      return await _db.isUserFollowed(uid: uid);
    } catch (e) {
      rethrow;
    }
  }

  Future<ChatModel?> doesChatExists({required String uid}) async {
    try {
      return await _db.doesChatExists(uid: uid);
    } catch (e) {
      rethrow;
    }
  }
}
