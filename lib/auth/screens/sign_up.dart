import 'dart:developer';
import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/auth/models/user_model.dart';
import 'package:final_year_project/auth/widgets/my_buttions.dart';
import 'package:final_year_project/auth/widgets/my_radio_buttons.dart';
import 'package:final_year_project/auth/widgets/decoration_for_textfields.dart';
import 'package:final_year_project/auth/widgets/third_party_icons.dart';
import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/common/controller/post_controller.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _passwordController = TextEditingController();
  final uniqueId = 1000;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: 150,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: decorationForTextFieldsContainers(),
                      width: 250,
                      height: screenHeight(context) * 0.1,
                      child: TextFormField(
                        controller: _nameController,
                        validator: ((value) {
                          if (value != null) {
                            return null;
                          } else {
                            return "Name is required";
                          }
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
                      width: 250,
                      height: screenHeight(context) * 0.1,
                      child: TextFormField(
                          controller: _emailController,
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
                      width: 250,
                      height: screenHeight(context) * 0.1,
                      child: TextFormField(
                          controller: _contactController,
                          validator: ((value) {
                            final expression = RegExp(
                                r"^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$");
                            if (!expression.hasMatch(value!)) {
                              return "The number should be 11 digits";
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
                      width: 250,
                      height: screenHeight(context) * 0.1,
                      child: TextFormField(
                        controller: _passwordController,
                        obscuringCharacter: "*",
                        obscureText: true,
                        validator: ((value) {
                          if (value!.length < 8) {
                            return "password shold be atleast 8 characters";
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
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyButtions(
                      width: 250,
                      height: 50,
                      text: "Sign Up",
                      onSelect: () async {
                        try {
                          if (_formKey.currentState!.validate()) {
                            Timestamp signUpTimestamp =
                                Timestamp.now(); // Example sign-up timestamp

                            String uniqueNumber =
                                signUpTimestamp.seconds.toString();
                            final user = UserModel(
                              uid: "",
                              name: _nameController.text,
                              email: _emailController.text,
                              contactNumber: _contactController.text,
                              uniqueId: uniqueNumber,
                            );
                            // ignore: use_build_context_synchronously
                            await context
                                .read<AuthController>()
                                .signUpWithEmailAndPassword(
                                    user: user,
                                    password: _passwordController.text);
                            // ignore: use_build_context_synchronously

                            // ignore: use_build_context_synchronously
                            context.read<PostController>().getCurrentUsersPosts(
                                uid: FirebaseAuth.instance.currentUser!.uid);
                            // ignore: use_build_context_synchronously
                            final myuser = await context
                                .read<AuthController>()
                                .checkCurrentUser(context);
                            if (myuser != null) {
                              log("uniqe id is : ${uniqueNumber.toString()}");
                              // ignore: use_build_context_synchronously
                              Navigator.of(context)
                                  .pushReplacementNamed(AppRouter.homeScreen);
                            } else {
                              Navigator.of(context).pushNamed(AppRouter.signUp);
                              // ignore: use_build_context_synchronously
                              showDialog(
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                        content: Text(
                                          'some error',
                                        ),
                                      ));
                            }
                            _nameController.clear();
                            _passwordController.clear();
                            _contactController.clear();
                            _emailController.clear();
                          }
                        } catch (e) {
                          print('sign up error');
                          showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                    content: Text(
                                      'Network error',
                                    ),
                                  ));
                        }
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have account?  ",
                          style: TextStyle(fontSize: 11),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(AppRouter.login);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text("Or"),
                    const ThirdPartyIcons()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
