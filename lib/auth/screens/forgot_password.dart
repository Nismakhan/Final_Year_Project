import 'package:final_year_project/auth/widgets/my_buttions.dart';
import 'package:final_year_project/screens/user_orginization.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        foregroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SizedBox(
              width: screenWidth(context) * 0.6,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 100,
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
                    SizedBox(
                      width: 380,
                      child: TextFormField(
                        validator: (value) {
                          final expression = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                          if (value!.isEmpty || !expression.hasMatch(value)) {
                            return "Enter Valid Email";
                          }
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Enter your email here..")),
                        controller: emailcontroller,
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
