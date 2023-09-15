import 'dart:developer';

import 'package:final_year_project/auth/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';

import '../../app/router/router.dart';
import '../controller/auth_controller.dart';

class FaceBookSignup {
  late LoginResult result;
  loginWithFacebook(BuildContext context) async {
    // try {
    //   // Log in with Facebook
    result = await FacebookAuth.instance.login(permissions: ['public_profile']);

    //   // Check if the login was successful
    //   if (result.status == LoginStatus.success) {
    //     print('success');
    //     // Fetch user profile data
    //     final userData = await FacebookAuth.instance.getUserData();
    //     print(userData.toString());

    //     // Display user data (you can customize this part)

    //     // ignore: use_build_context_synchronously
    //     showDialog(
    //       context: context,
    //       builder: (context) {
    //         return AlertDialog(
    //           title: const Text('Facebook User Data'),
    //           content: Column(
    //             children: [
    //               Text(userData['name']),
    //               Image.network(userData['picture']['data']['url']),
    //             ],
    //           ),
    //           actions: [
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //               child: const Text('OK'),
    //             ),
    //           ],
    //         );
    //       },
    //     );
    //   } else {
    //     // Handle login error
    //     print('Facebook login failed');
    //   }
    // } catch (e) {
    //   // Handle other exceptions
    //   print('Error: $e');
    // }
    final accessToken = result.accessToken;

    if (accessToken != null) {
      log(accessToken.token.toString());
      final OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);
      log(credential.toString());
      return FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        print('kkkkkkkkkkkkk');
        try {
          final data = UserModel(
            uid: value.user!.uid,
            name: value.user?.displayName.toString() ?? 'not found',
            email: value.user!.email.toString(),
            profileUrl: value.user!.photoURL,
            //uniqueId: uniqueNumber,
          );
          context.read<AuthController>().signupwithFacebook(user: data);
          final myuser =
              await context.read<AuthController>().checkCurrentUser(context);
          log(myuser.toString());
          if (myuser != null) {
            Navigator.of(context).pushReplacementNamed(AppRouter.homeScreen);
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
        } catch (e) {
          log(e.toString());
        }

        // user = data;
        // .return Navigator.of(context).pushReplacementNamed(AppRouter.home);
        // });
      });
    } else {
      print('Access token is null');
    }
  }
}
