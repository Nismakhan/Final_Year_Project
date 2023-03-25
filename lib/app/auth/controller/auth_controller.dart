import 'dart:developer';
import 'package:final_year_project/app/auth/db/database.dart';
import 'package:final_year_project/app/auth/models/user_model.dart';
import 'package:final_year_project/app/router/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthController extends ChangeNotifier {
  UserModel? appUser;
  final AuthBD _db = AuthBD();

  Future<void> logInWithEmailAndPassword(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      appUser = await _db.signInWithEmailAndPassword(email, password);
      Navigator.of(context).pushReplacementNamed(AppRouter.dashboard);
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  Future<void> signUpWithEmailAndPassword(
    BuildContext context, {
    required UserModel name,
    required UserModel email,
    required UserModel contact,
    required String password,
  }) async {
    try {
      final credentials = await _db.signUpWithEmailAndPassword(
          name: name, email: email, contact: contact, password: password);
      appUser = email;

      Navigator.of(context).pushReplacementNamed(AppRouter.dashboard);
      log("new current user: ${appUser?.toJson().toString()}");
      notifyListeners();
    } catch (e) {
      print("error in controller $e");
    }
  }
}
