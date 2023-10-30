import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/auth/auth_services/facebook_sign_in.dart';
import 'package:final_year_project/auth/models/user_model.dart';
import 'package:final_year_project/models/follow_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/chat_model.dart';

class AuthBD {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // return await getUserById(credentials.user!.uid);
    } on FirebaseAuthException catch (error, stacktrace) {
      print("An error occur: $error");
      rethrow;
    }
    return null;
  }

  Future<User?> signUpWithEmailAndPassword({
    required UserModel user,
    required String password,
  }) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      user.uid = credentials.user!.uid;
      await _firestore
          .collection("users")
          .doc(credentials.user!.uid)
          .set(user.toJson());
    } on FirebaseAuthException catch (error, stacktrace) {
      rethrow;
    }
  }

  Future<void> googleSignUp(
    final UserModel user,
  ) async {
    await _firestore.collection('users').doc(user.uid).set(user.toJson());
  }

  Future<void> facebookSignUp(
    final UserModel user,
  ) async {
    await _firestore.collection('users').doc(user.uid).set(user.toJson());
  }

  Future<void> githubSignUp(
    final UserModel user,
  ) async {
    await _firestore.collection('users').doc(user.uid).set(user.toJson());
  }

  User? isCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> updateUser({required UserModel user}) async {
    try {
      await _firestore.collection("users").doc(user.uid).update(user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserById(String userId) async {
    try {
      final snapshot = await _firestore.collection("users").doc(userId).get();
      if (!snapshot.exists) {
        throw FirebaseAuthException(code: "200");
      }

      final data = snapshot.data();
      return UserModel.fromJson(data!);
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  Future<void> followUser(
      {required FollowModel myFollowModel,
      required FollowModel followModel}) async {
    try {
      // put otherUserdata in my followed
      // put my data in his followers
      await _firestore
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .collection("followed")
          .doc(followModel.uid)
          .set(followModel.toJson());

      await _firestore
          .collection("users")
          .doc(followModel.uid)
          .collection("followers")
          .doc(_firebaseAuth.currentUser!.uid)
          .set(myFollowModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> unFollow({required String uid}) async {
    try {
      // remove his doc from my followed list
      await _firestore
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .collection("followed")
          .doc(uid)
          .delete();

      // remove my data from his follower list
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("followers")
          .doc(_firebaseAuth.currentUser!.uid)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeFollower({required String uid}) async {
    try {
      // remove his doc from my follower list
      await _firestore
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .collection("followers")
          .doc(uid)
          .delete();

      // remove my data from his followed list
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("followed")
          .doc(_firebaseAuth.currentUser!.uid)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isUserFollowed({required String uid}) async {
    try {
      return (await _firestore
              .collection("users")
              .doc(_firebaseAuth.currentUser!.uid)
              .collection("followed")
              .doc(uid)
              .get())
          .exists;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isUserFollowing({required String uid}) async {
    try {
      return (await _firestore
              .collection('users')
              .doc(_firebaseAuth.currentUser!.uid)
              .collection('following')
              .doc(uid)
              .get())
          .exists;
    } catch (e) {
      rethrow;
    }
  }

  Future<ChatModel?> doesChatExists({required String uid}) async {
    try {
      final docs = (await _firestore
              .collection("chats")
              .where("userIds", arrayContains: uid)
              .get())
          .docs;
      if (docs.isNotEmpty) {
        return ChatModel.fromJson(docs.first.data());
      } else {
        log("null");
      }
      return null;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
