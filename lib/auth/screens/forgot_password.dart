import 'package:final_year_project/auth/widgets/decoration_for_textfields.dart';
import 'package:final_year_project/common/textfield_decoration.dart';
import 'package:final_year_project/screens/user_orginization.dart';
import 'package:final_year_project/utils/colors.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/router/router.dart';

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
          return const AlertDialog(
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
        foregroundColor: Colors.white,
        backgroundColor: AppColors.blueColor,
        title: const Text('Forgot'),
      ),
      body: Stack(
        children: [
          kIsWeb
              ? const Positioned(
                  right: -35,
                  top: -35,
                  child: CircleAvatar(
                    backgroundColor: AppColors.blueColor,
                    radius: 100,
                  ),
                )
              : const SizedBox(),
          kIsWeb
              ? const Positioned(
                  bottom: -35,
                  left: -35,
                  child: CircleAvatar(
                    backgroundColor: AppColors.blueColor,
                    radius: 100,
                  ),
                )
              : const SizedBox(),
          Center(
            child: SizedBox(
                width: kIsWeb ? 330 : screenWidth(context) * 0.8,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        width: 300.w,
                        height: 360.h,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          "Please Enter Your Email Address To Recieve a Varification Code",
                          style: TextStyle(fontSize: kIsWeb ? 13 : 13.sp),
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
                              controller: emailcontroller,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child:
                              ElevatedButtons(onPres: resetEmail, text: 'Send'))
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
