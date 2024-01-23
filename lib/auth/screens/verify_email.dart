import 'dart:async';
import 'dart:developer';

import 'package:final_year_project/app/router/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifiEmail extends StatefulWidget {
  const VerifiEmail({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  @override
  State<VerifiEmail> createState() => _VerifiEmailState();
}

class _VerifiEmailState extends State<VerifiEmail> {
  bool isEmail = false;
  Timer? timer;

  @override
  void initState() {
    log('object');
    startTimer();
    super.initState();

    // Start the timer when the widget is initialized
  }

  void startTimer() {
    print('object');
    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      checkEmailVerification();
    });
  }

  void checkEmailVerification() async {
    print('object');
    print('Checking email verification');
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print('object');
      await user.reload();
      user = FirebaseAuth.instance.currentUser;

      setState(() {
        isEmail = user?.emailVerified ?? false;
      });

      if (isEmail) {
        timer?.cancel();
        Navigator.of(context).pushReplacementNamed(AppRouter.homeScreen);
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Email Has Been Send To The ${widget.email} !  Please Verify',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle button press if needed
              },
              child: const Text('Button Text'),
            )
          ],
        ),
      ),
    );
  }
}
