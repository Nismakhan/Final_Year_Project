import 'package:final_year_project/auth/widgets/my_buttions.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:flutter/material.dart';

class ForgotPassward extends StatelessWidget {
  const ForgotPassward({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot password"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SizedBox(
              width: screenWidth(context) * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 215, 255, 216),
                    radius: 100,
                    child: Icon(
                      Icons.lock_open_outlined,
                      color: Colors.black,
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
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 380,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Enter your email here..")),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyButtions(
                      width: 250, height: 50, text: "Send", onSelect: () {})
                ],
              )),
        ),
      ),
    );
  }
}
