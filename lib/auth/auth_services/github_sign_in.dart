import 'dart:convert';
import 'dart:developer';

import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/auth/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class GitHubLogIn {
  loginWithGitHub(BuildContext context) async {
    try {
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: '9abff04655ae4d198381',
        clientSecret: 'e974f31106717d394ef550f75e6ce751645d1294',
        redirectUrl:
            'https://final-year-project-91ce0.firebaseapp.com/__/auth/handler',
      );

      final result = await gitHubSignIn.signIn(context);
      final credential = GithubAuthProvider.credential(result.token!);

      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        print('kkkkkkkkk');
        try {
          print('hhhhhhhh');

          final data = UserModel(
            uid: value.user!.uid,
            name: value.user?.displayName.toString() ?? 'not found',
            email: value.user!.email.toString(),
            profileUrl: value.user!.photoURL.toString(),
          );
          context.read<AuthController>().signupwithGithub(user: data);
          final myuser =
              await context.read<AuthController>().checkCurrentUser(context);
          log(myuser.toString());
          if (myuser != null) {
            Navigator.of(context).pushReplacementNamed(AppRouter.homeScreen);
            print('replacement');
          } else {
            Navigator.of(context).pushReplacementNamed(AppRouter.login);
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                content: Text('Some error occurred.'),
              ),
            );
          }
        } catch (e) {
          log(e.toString());
        }
      });

      // print('inside of github');
      // GithubAuthProvider githubAuthProvider = GithubAuthProvider();
      // final userdata =
      //     await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);

      // // Fetch additional user data from GitHub API
      // const githubToken = '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';

      // log('github token is : $githubToken');
      // final githubUsername = await getGitHubUsername(githubToken);
      // log('username is : ${githubUsername}');

      // // Display GitHub username
      // // ignore: use_build_context_synchronously
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       title: const Text('GitHub User Data'),
      //       content: Column(
      //         children: [
      //           Text('GitHub Username: $githubUsername'),
      //           Image.network(userdata.user!.photoURL.toString()),
      //         ],
      //       ),
      //       actions: [
      //         TextButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           child: const Text('OK'),
      //         ),
      //       ],
      //     );
      //   },
      // );
    } catch (e) {
      // Handle any errors that may occur during sign-in.
      print('Error signing in with GitHub: $e');
    }
  }

  Future<String> getGitHubUsername(String githubToken) async {
    final response = await http.get(
      Uri.parse('https://api.github.com/user'),
      headers: {
        'Authorization': 'Bearer $githubToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);
      final String githubUsername = userData['login'];
      return githubUsername;
    } else {
      print(
          'Failed to fetch GitHub username. Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception('Failed to fetch GitHub username');
    }
  }
}
