import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/auth/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:provider/provider.dart';

import '../../app/router/router.dart';
import '../controller/auth_controller.dart';

class GoogleServices {
  signinWithgoogle(BuildContext context, String type) async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    var user = context.read<AuthController>().appUser;
    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) async {
      print('kkkkkkkkkkkkkkkkkk');
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Center(
                  child: CircularProgressIndicator(),
                ),
              ));

      //  value.user.displayName
      try {
        Timestamp signUpTimestamp =
            Timestamp.now(); // Example sign-up timestamp

        String uniqueNumber = signUpTimestamp.seconds.toString();
        final data = UserModel(
          uid: value.user!.uid,
          name: value.user?.displayName.toString() ?? 'not found',
          email: value.user!.email.toString(),
          profileUrl: value.user!.photoURL,
          uniqueId: uniqueNumber,
        );
        context.read<AuthController>().signupwithGoogle(user: data);
        final myuser =
            await context.read<AuthController>().checkCurrentUser(context);
        log(myuser.toString());
        if (myuser != null) {
          Navigator.of(context).pushReplacementNamed(AppRouter.dashboard);
          print('replacement');
        } else {
          Navigator.of(context).pushReplacementNamed(AppRouter.login);
          // ignore: use_build_context_synchronously
           showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                    content: Text(
                      'some error occured',
                    ),
                  ));
        }

        // user = data;
        // .return Navigator.of(context).pushReplacementNamed(AppRouter.home);
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
