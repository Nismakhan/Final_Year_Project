import 'package:final_year_project/app/router/router.dart';
import 'package:flutter/material.dart';

import '../widgets/my_buttions.dart';
import '../widgets/my_radio_buttons.dart';
import '../widgets/my_text_fields.dart';
import '../widgets/third_party_icons.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const MyRadioButtons(),
                      const MyTextFields(
                        text: "Example@gmail.com",
                        icons: Icons.person,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const MyTextFields(
                        text: "******",
                        icons: Icons.lock,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyButtions(
                        text: "Logi",
                        onSelect: () {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyButtions(
                        text: "SignUp",
                        onSelect: () {
                          Navigator.of(context)
                              .pushReplacementNamed(AppRouter.signUp);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "forgot passward ? ",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Click here",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Text("Or"),
                      const SizedBox(
                        height: 10,
                      ),
                      const ThirdPartyIcons()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
