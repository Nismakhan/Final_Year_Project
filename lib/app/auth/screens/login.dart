import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/app/auth/widgets/my_buttions.dart';
import 'package:final_year_project/app/auth/widgets/my_radio_buttons.dart';
import 'package:final_year_project/app/auth/widgets/third_party_icons.dart';
import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwardController = TextEditingController();
  String a = 'Password not corrext';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight(context) * 0.1,
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
                            //color: const Color.fromARGB(255, 226, 226, 226),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 300,
                          child: TextFormField(
                            controller: _emailController,
                            validator: ((value) {
                              final expression = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                              if (!expression.hasMatch(value!)) {
                                return 'Invalid Email';
                              }
                              return null;
                            }),
                            decoration: InputDecoration(
                              fillColor: Colors.red,
                              label: const Text('Email'),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 3),
                              ),
                              suffixIcon: const Icon(
                                Icons.mail,
                                size: 25,
                                color: Colors.blue,
                              ),
                              hintText: "Example@gmail.com",
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 300,
                          child: TextFormField(
                            controller: _passwardController,
                            obscuringCharacter: "*",
                            obscureText: true,
                            validator: ((value) {
                              if (value!.length < 6) {
                                return a;
                              }
                              return null;
                            }),
                            decoration: InputDecoration(
                              label: const Text('Enter Password'),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 3)),
                              suffixIcon: const Icon(
                                Icons.lock,
                                size: 25,
                                color: Colors.blue,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: const OutlineInputBorder(
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
                              final FirebaseAuth auth = FirebaseAuth.instance;
                              final FirebaseFirestore store =
                                  FirebaseFirestore.instance;
                              await auth.signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwardController.text,
                              );
                              Navigator.of(context)
                                  .pushNamed(AppRouter.dashboard);
                            } else {
                              Navigator.of(context).pushNamed(AppRouter.login);
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
