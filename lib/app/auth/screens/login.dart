import 'package:final_year_project/app/auth/widgets/my_buttions.dart';
import 'package:final_year_project/app/auth/widgets/my_radio_buttons.dart';
import 'package:final_year_project/app/auth/widgets/third_party_icons.dart';
import 'package:final_year_project/app/router/router.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwardController = TextEditingController();
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const MyRadioButtons(),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 226, 226, 226),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 300,
                          child: TextFormField(
                            controller: _emailController,
                            validator: ((value) {
                              final expression = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                              if (!expression.hasMatch(value!)) {
                                return "Email is invalid";
                              }
                              return null;
                            }),
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.abc,
                              ),
                              labelText: "Example@gmail.com",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 226, 226, 226),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 300,
                          child: TextFormField(
                            controller: _passwardController,
                            obscuringCharacter: "*",
                            obscureText: true,
                            validator: ((value) {
                              if (value!.length < 6) {
                                return "Passward should be atleast 6 characters";
                              }
                              return null;
                            }),
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.abc,
                              ),
                              labelText: "**********",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyButtions(
                          text: "Login",
                          onSelect: () async {
                            if (_formKey.currentState!.validate()) {
                              Navigator.of(context).pushNamed(AppRouter.signUp);
                            }
                          },
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
