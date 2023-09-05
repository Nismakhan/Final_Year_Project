import 'dart:developer';

import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/common/stack_circles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserOrganization extends StatefulWidget {
  const UserOrganization({super.key});

  @override
  State<UserOrganization> createState() => _UserOrganizationState();
}

class _UserOrganizationState extends State<UserOrganization> {
  bool isUser = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            kIsWeb
                ? Positioned(
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 184, 181, 218),
                      radius: 80,
                      child: Image.asset("assets/images/small logo.png"),
                    ),
                  )
                : const SizedBox(),
            kIsWeb
                ? Positioned(
                    bottom: 0,
                    right: -100,
                    child: StackCirlcles(
                      // width: screenW(context) *
                      width: screenWidth(context) * 0.30,
                      height: screenHeight(context) * 0.30,
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: screenHeight(context) * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth(context) * 0.45,
                        height: 250,
                        child: Image.asset("assets/images/logo.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: SizedBox(
                          width: screenWidth(context),
                          child: Column(
                            children: [
                              const Text(
                                "ARE YOU A",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: screenHeight(context) * 0.04,
                              ),
                              SizedBox(
                                width: screenWidth(context) * 0.6,
                                child: ElevatedButtons(
                                  onPres: () {
                                    Navigator.of(context).pushNamed(
                                        AppRouter.login,
                                        arguments:
                                            isUser ? "User" : "Organization");
                                  },
                                  text: 'Organization',
                                ),
                              ),
                              SizedBox(
                                height: screenHeight(context) * 0.04,
                              ),
                              const Text(
                                "OR",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: screenHeight(context) * 0.04,
                              ),
                              ElevatedButtons(
                                  onPres: () {
                                    setState(() {
                                      isUser = true;
                                    });
                                    Navigator.of(context).pushNamed(
                                        AppRouter.login,
                                        arguments:
                                            isUser ? "User" : "Organization");
                                  },
                                  text: "User"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackElevatedButton extends StatelessWidget {
  const BackElevatedButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.blue,
          size: 25,
        ),
      ),
    );
  }
}

class ElevatedButtons extends StatelessWidget {
  ElevatedButtons({
    required this.onPres,
    required this.text,
    this.isloading = false,
    Key? key,
  }) : super(key: key);
  final bool isloading;
  final String text;
  final Function() onPres;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        return SizedBox(
          width: p1.maxWidth > 600 ? 300 : screenWidth(context) * 0.5,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    //side: BorderSide(color: Colors.blue, width: 3),
                    borderRadius: BorderRadius.circular(15)),
                elevation: 10,
                backgroundColor: const Color.fromARGB(255, 114, 154, 224)),
            onPressed: () {
              log('kamal');
              onPres();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              child: Center(
                child: isloading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        text,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
