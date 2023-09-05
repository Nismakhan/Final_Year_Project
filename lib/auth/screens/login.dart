import 'dart:developer';
import 'package:final_year_project/auth/auth_services/facebook_sign_in.dart';
import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/auth/widgets/decoration_for_textfields.dart';
import 'package:final_year_project/auth/widgets/my_buttions.dart';
import 'package:final_year_project/auth/widgets/third_party_icons.dart';
import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/common/controller/post_controller.dart';
import 'package:final_year_project/screens/user_orginization.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/common/stack_circles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_services/google_sign_up.dart';
import '../controller/loading_controller.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
    required this.type,
  });
  final String type;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwardController = TextEditingController();

  String a = 'Password not correct';
  bool _isHidden = true;
  void togglePasswordView() {
    setState(() {
      print('azan');
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                constraints.maxWidth > 550
                    ? Positioned(
                        top: -30,
                        left: -150,
                        child: StackCirlcles(
                          width: screenWidth(context) * 0.27,
                          height: screenHeight(context) * 0.27,
                        ),
                      )
                    : const SizedBox(),
                constraints.maxWidth > 550
                    ? Positioned(
                        bottom: -20,
                        right: -150,
                        child: StackCirlcles(
                          width: screenWidth(context) * 0.27,
                          height: screenHeight(context) * 0.27,
                        ),
                      )
                    : const SizedBox(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      width: screenWidth(context) * 0.7,
                      child: Builder(builder: (context) {
                        return Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/images/logo.png",
                                  width: 200,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  decoration:
                                      decorationForTextFieldsContainers(),
                                  width: 250,
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
                                    decoration: decorationForTextfields(
                                        text: "Enter Email", icon: Icons.email),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration:
                                      decorationForTextFieldsContainers(),
                                  width: 250,
                                  child: TextFormField(
                                    controller: _passwardController,
                                    obscuringCharacter: "*",
                                    obscureText: _isHidden ? true : false,
                                    validator: ((value) {
                                      if (value!.length < 6) {
                                        return a;
                                      }
                                      return null;
                                    }),
                                    decoration: decorationForTextfields(
                                      onTap: togglePasswordView,
                                      text: "Enter Password",
                                      icon: Icons.key_outlined,
                                      suffix: _isHidden
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "forgot passward ? ",
                                      style: TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            AppRouter.forgotPassword);
                                      },
                                      child: const Text(
                                        "Click here",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Consumer<AuthController>(
                                  builder: (context, value, child) {
                                    // return MyButtions(
                                    //   isloading: value.isloading,
                                    //   width: 250,
                                    //   height: 50,
                                    //   text: "Login",
                                    //   onSelect: () async {

                                    //   },
                                    // );
                                    final load =
                                        context.read<LoadingController>();
                                    return ElevatedButtons(
                                        isloading: load.isloading,
                                        onPres: () async {
                                          try {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              load.loading();
                                              // ignore: use_build_context_synchronously
                                              await context
                                                  .read<AuthController>()
                                                  .logInWithEmailAndPassword(
                                                      email:
                                                          _emailController.text,
                                                      password:
                                                          _passwardController
                                                              .text);
                                              load.loading();
                                              // ignore: use_build_context_synchronously
                                              final posts = context
                                                  .read<PostController>()
                                                  .getCurrentUsersPosts(
                                                      uid: FirebaseAuth.instance
                                                          .currentUser!.uid);
                                              log("a m clikking");
                                              // ignore: use_build_context_synchronously
                                              final myUser = await context
                                                  .read<AuthController>()
                                                  .checkCurrentUser(context);
                                              if (myUser != null &&
                                                  posts != null) {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        AppRouter.homeScreen);
                                              } else {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        AppRouter.login);
                                                // ignore: use_build_context_synchronously
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        const AlertDialog(
                                                          content: Text(
                                                            'Enter Correct Credential',
                                                          ),
                                                        ));
                                              }
                                              _emailController.clear();
                                              _passwardController.clear();
                                            }
                                          } catch (e) {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    const AlertDialog(
                                                      content: Text(
                                                        'Network error',
                                                      ),
                                                    ));
                                            load.loading();
                                          }
                                        },
                                        text: 'Login');
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "dont have an account?  ",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                AppRouter.signUp,
                                                arguments: widget.type);
                                      },
                                      child: const Text(
                                        "SignUp",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 15,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        print('google');
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const AlertDialog(
                                                  content: Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                ));
                                        print(widget.type.toString());
                                        GoogleServices().signinWithgoogle(
                                            context, widget.type);
                                        Navigator.pop(context);
                                      },
                                      child: SizedBox(
                                        child: Image.asset(
                                          "assets/images/google.png",
                                          height: 50,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print('facebook');
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const AlertDialog(
                                                  content: Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                ));
                                        print(widget.type.toString());
                                        FaceBookSignup().loginWithFacebook(
                                          context,
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: SizedBox(
                                        child: Image.asset(
                                          "assets/images/facebook.png",
                                          height: 50,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
