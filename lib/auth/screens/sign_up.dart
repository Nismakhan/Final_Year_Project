import 'dart:developer';
import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/auth/models/user_model.dart';
import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/auth/widgets/decoration_for_textfields.dart';
import 'package:final_year_project/common/Extensions/custom_sizedbox.dart';
import 'package:final_year_project/common/controller/post_controller.dart';
import 'package:final_year_project/screens/user_orginization.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth_services/google_sign_up.dart';
import 'package:final_year_project/auth/auth_services/facebook_sign_in.dart';
import 'package:final_year_project/common/textfield_decoration.dart';
import 'package:final_year_project/utils/colors.dart';
import 'package:final_year_project/widgets/common/stack_circles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart';
import '../controller/loading_controller.dart';

class SignUp extends StatefulWidget {
  SignUp({
    super.key,
    required this.type,
  });
  final String type;
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _typecontroller = TextEditingController();

  final _passwordController = TextEditingController();

  final uniqueId = 1000;
  bool _isHidden = true;
  void togglePasswordView() {
    setState(() {
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
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      width: kIsWeb ? 350 : screenWidth(context) * 0.7,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/images/logo.png",
                              width: 270.w,
                              height: 280.h,
                            ),
                            10.cusSH,
                            Column(
                              children: [
                                Container(
                                  width: 380.w,
                                  height: 80.h,
                                  decoration:
                                      containerShapeDecorationForTextField(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextFormField(
                                        controller: _nameController,
                                        validator: ((value) {
                                          if (value!.isEmpty) {
                                            return "Name is required";
                                          } else {
                                            return null;
                                          }
                                        }),
                                        decoration: inputDecorationForTextField(
                                          prefixIcon: Icons.person,
                                          hintText: "Enter Name",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                10.cusSH,
                                Container(
                                  width: 380.w,
                                  height: 80.h,
                                  decoration:
                                      containerShapeDecorationForTextField(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextFormField(
                                        controller: _emailController,
                                        validator: ((value) {
                                          final expression = RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                          if (!expression.hasMatch(value!) ||
                                              (value.isEmpty)) {
                                            return "Enter Correct Credential";
                                          }
                                          return null;
                                        }),
                                        decoration: inputDecorationForTextField(
                                          prefixIcon: Icons.email,
                                          hintText: "Enter Email",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                10.cusSH,
                                Container(
                                  width: 380.w,
                                  height: 80.h,
                                  decoration:
                                      containerShapeDecorationForTextField(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextFormField(
                                        controller: _passwordController,
                                        obscuringCharacter: "*",
                                        obscureText: _isHidden ? true : false,
                                        validator: ((value) {
                                          if (value!.length < 8) {
                                            return "password shold be atleast 8 characters";
                                          }
                                          return null;
                                        }),
                                        decoration: inputDecorationForTextField(
                                          prefixIcon: Icons.email,
                                          suffixIcon: GestureDetector(
                                            onTap: () => togglePasswordView(),
                                            child: Icon(
                                              _isHidden
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              size: kIsWeb ? 17 : 17.sp,
                                            ),
                                          ),
                                          hintText: "Enter Password",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                10.cusSH,
                                Container(
                                  width: 380.w,
                                  height: 80.h,
                                  decoration:
                                      containerShapeDecorationForTextField(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextFormField(
                                        controller: _typecontroller,
                                        validator: ((value) {
                                          if (value!.isEmpty) {
                                            return "Select a Type";
                                          }
                                          return null;
                                        }),
                                        decoration: inputDecorationForTextField(
                                          prefixIcon: Icons.email,
                                          suffixIcon: PopupMenuButton<String>(
                                            onSelected: (value) {
                                              setState(() {
                                                _typecontroller.text = value;
                                              });
                                            },
                                            itemBuilder:
                                                (BuildContext context) {
                                              return <PopupMenuEntry<String>>[
                                                const PopupMenuItem<String>(
                                                  value: 'User',
                                                  child: Text('User'),
                                                ),
                                                const PopupMenuItem<String>(
                                                  value: 'Organization',
                                                  child: Text('Organization'),
                                                ),
                                              ];
                                            },
                                          ),
                                          hintText: "Select type",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                20.cusSH,
                                Column(
                                  children: [
                                    ElevatedButtons(
                                      text: 'SignUp',
                                      onPres: () async {
                                        try {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            Timestamp signUpTimestamp = Timestamp
                                                .now(); // Example sign-up timestamp

                                            String uniqueNumber =
                                                signUpTimestamp.seconds
                                                    .toString();
                                            final user = UserModel(
                                              uid: '',
                                              name: _nameController.text,
                                              email: _emailController.text,
                                              organization:
                                                  _typecontroller.text,
                                              uniqueId: uniqueNumber,
                                            );
                                            // ignore: use_build_context_synchronously
                                            await context
                                                .read<AuthController>()
                                                .signUpWithEmailAndPassword(
                                                    user: user,
                                                    password:
                                                        _passwordController
                                                            .text);
                                            // ignore: use_build_context_synchronously

                                            // ignore: use_build_context_synchronously
                                            context
                                                .read<PostController>()
                                                .getCurrentUsersPosts(
                                                    uid: FirebaseAuth.instance
                                                        .currentUser!.uid);
                                            // ignore: use_build_context_synchronously
                                            final myuser = await context
                                                .read<AuthController>()
                                                .checkCurrentUser(context);
                                            if (myuser != null) {
                                              log("uniqe id is : ${uniqueNumber.toString()}");
                                              // ignore: use_build_context_synchronously
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      AppRouter.homeScreen);
                                            } else {
                                              Navigator.of(context)
                                                  .pushNamed(AppRouter.signUp);
                                              // ignore: use_build_context_synchronously
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const AlertDialog(
                                                        content: Text(
                                                          'some error',
                                                        ),
                                                      ));
                                            }
                                            _nameController.clear();
                                            _passwordController.clear();
                                            _typecontroller.clear();
                                            _emailController.clear();
                                          }
                                        } catch (e) {
                                          print('sign up error');
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const AlertDialog(
                                                    content: Text(
                                                      'Network error',
                                                    ),
                                                  ));
                                        }
                                      },
                                    ),
                                    15.cusSH,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Already have account?  ",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                AppRouter.login,
                                                arguments: widget.type,
                                              );
                                            },
                                            child: const Text(
                                              "Login",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: AppColors.blueColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Or",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    15.cusSH,
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
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
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
