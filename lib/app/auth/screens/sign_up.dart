import 'package:final_year_project/app/auth/widgets/textfileds_and_buttons_column.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo.png",
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: TextfieldsAndButtonsForSignUp(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
