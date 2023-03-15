import 'package:final_year_project/app/auth/widgets/my_buttions.dart';
import 'package:final_year_project/app/auth/widgets/my_radio_buttons.dart';
import 'package:final_year_project/app/auth/widgets/decoration_for_textfields.dart';
import 'package:final_year_project/app/auth/widgets/third_party_icons.dart';
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
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const MyRadioButtons(),
                      Container(
                        decoration: decorationForTextFieldsContainers(),
                        width: 300,
                        child: TextFormField(
                          validator: ((value) {
                            final expression = RegExp("");
                            if (!expression.hasMatch(value!)) {
                              return "";
                            }
                            return null;
                          }),
                          decoration: decorationForTextfields(
                              text: "Enter Name", icon: Icons.person),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: decorationForTextFieldsContainers(),
                        width: 300,
                        child: TextFormField(
                            validator: ((value) {
                              final expression = RegExp("");
                              if (!expression.hasMatch(value!)) {
                                return "";
                              }
                              return null;
                            }),
                            decoration: decorationForTextfields(
                                text: "Enter Email", icon: Icons.email)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: decorationForTextFieldsContainers(),
                        width: 300,
                        child: TextFormField(
                            validator: ((value) {
                              final expression = RegExp("");
                              if (!expression.hasMatch(value!)) {
                                return "";
                              }
                              return null;
                            }),
                            decoration: decorationForTextfields(
                                text: "Enter Your Contact", icon: Icons.call)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: decorationForTextFieldsContainers(),
                        width: 300,
                        child: TextFormField(
                            validator: ((value) {
                              final expression = RegExp("");
                              if (!expression.hasMatch(value!)) {
                                return "";
                              }
                              return null;
                            }),
                            decoration: decorationForTextfields(
                                text: "Enter Passward",
                                icon: Icons.remove_red_eye)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyButtions(
                        text: "Sign Up",
                        onSelect: () {},
                      ),
                      const SizedBox(
                        height: 10,
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
                                color: Color(0xFF6C63FF),
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
