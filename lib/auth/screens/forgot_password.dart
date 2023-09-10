import 'package:final_year_project/auth/widgets/decoration_for_textfields.dart';
import 'package:final_year_project/screens/user_orginization.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../app/router/router.dart';
import 'package:final_year_project/auth/auth_services/facebook_sign_in.dart';
import 'package:final_year_project/auth/controller/auth_controller.dart';

import 'package:final_year_project/common/Extensions/custom_sizedbox.dart';
import 'package:final_year_project/common/controller/post_controller.dart';
import 'package:final_year_project/common/textfield_decoration.dart';
import 'package:final_year_project/screens/user_orginization.dart';
import 'package:final_year_project/utils/colors.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/common/stack_circles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import '../auth_services/google_sign_up.dart';
import '../controller/loading_controller.dart';

class ForgotPassward extends StatefulWidget {
  const ForgotPassward({super.key});

  @override
  State<ForgotPassward> createState() => _ForgotPasswardState();
}

class _ForgotPasswardState extends State<ForgotPassward> {
  final emailcontroller = TextEditingController();
  Future resetEmail() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontroller.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Check your Email'),
          );
        },
      );
      Navigator.of(context).pushNamed(AppRouter.login);
    } on FirebaseAuthException catch (e) {
      return showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Email May Not Found'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot password"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.blueColor,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SizedBox(
              width: kIsWeb ? 300 : screenWidth(context) * 0.6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundColor: AppColors.blueColor,
                      radius: 80,
                      child: Icon(
                        Icons.lock_open_outlined,
                        color: Colors.white,
                        size: 100,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      width: 300,
                      child: Text(
                        "Please Enter Your Email Address To Recieve a Varification Code",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 380.w,
                      height: 80.h,
                      decoration: containerShapeDecorationForTextField(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Align(
                          alignment: Alignment.center,
                          child: TextFormField(
                            validator: (value) {
                              final expression = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                              if (value!.isEmpty ||
                                  !expression.hasMatch(value)) {
                                return "Enter Valid Email";
                              }
                              return null;
                            },
                            decoration: decorationForTextfields(
                                text: "Enter your email here",
                                icon: Icons.email),
                            // decoration: const InputDecoration(
                            //     border: OutlineInputBorder(),
                            //     label: Text("Enter your email here..")),
                            controller: emailcontroller,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButtons(onPres: resetEmail, text: 'Send')
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
