import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GitHubSignIn {
  loginWithGitHub(BuildContext context) async {
    try {
      GithubAuthProvider githubAuthProvider = GithubAuthProvider();
      final userdata =
          await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);

      // Fetch additional user data from GitHub API
      const githubToken = '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';

      log('github token is : $githubToken');
      final githubUsername = await getGitHubUsername(githubToken);
      log('username is : ${githubUsername}');

      // Display GitHub username
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('GitHub User Data'),
            content: Column(
              children: [
                Text('GitHub Username: $githubUsername'),
                Image.network(userdata.user!.photoURL.toString()),
              ],
            ),
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
