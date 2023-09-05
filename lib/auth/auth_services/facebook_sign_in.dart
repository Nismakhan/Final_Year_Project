import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FaceBookSignup {
  late LoginResult result;
  Future<UserCredential> loginWithFacebook(BuildContext context) async {
    try {
      // Log in with Facebook
      result =
          await FacebookAuth.instance.login(permissions: ["public_profile"]);

      // Check if the login was successful
      if (result.status == LoginStatus.success) {
        print('success');
        // Fetch user profile data
        final userData = await FacebookAuth.instance.getUserData();
        print(userData.toString());

        // Display user data (you can customize this part)

        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Facebook User Data'),
              content: Text(userData.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Handle login error
        print('Facebook login failed');
      }
    } catch (e) {
      // Handle other exceptions
      print('Error: $e');
    }
    final OAuthCredential credential =
        FacebookAuthProvider.credential(result.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(credential);
  }
}
