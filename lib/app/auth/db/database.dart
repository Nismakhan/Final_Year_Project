import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/app/auth/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBD {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserModel?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // return await getUserById(credentials.user!.uid);
    } on FirebaseAuthException catch (error, stacktrace) {
      print("An error occur: $error");
      rethrow;
    }
  }

  // Future<UserModel> getUserById(String userId) async {
  //   try {
  //     final snapShot =
  //         await _firebaseFirestore.collection("users").doc(userId).get();
  //     if (snapShot.exists) {
  //       final data = snapShot.data();
  //       return UserModel.fromJson(data!);
  //     } else {
  //       throw "No user found";
  //     }
  //   } on FirebaseException {
  //     rethrow;
  //   }
  // }

  Future<User?> signUpWithEmailAndPassword({
    required UserModel name,
    required UserModel email,
    required UserModel contact,
    required String password,
  }) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.email, password: password);
      // user.uid = credentials.user!.uid;
      // await _firebaseFirestore
      //     .collection("users")
      //     .doc(credentials.user!.uid)
      //     .set(user.toJson());
      // return credentials.user!;
    } on FirebaseAuthException catch (error, stacktrace) {
      rethrow;
    }
  }
}
