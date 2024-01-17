import 'dart:developer';

import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/common/Extensions/custom_sizedbox.dart';
import 'package:final_year_project/common/elevated_button_style.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';

class UserOrganization extends StatefulWidget {
  const UserOrganization({super.key});

  @override
  State<UserOrganization> createState() => _UserOrganizationState();
}

class _UserOrganizationState extends State<UserOrganization> {
  bool isUser = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  height: screenHeight(context),
                  width: kIsWeb ? 300 : screenWidth(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        width: 300.w,
                        height: 360.h,
                      ),
                      20.cusSH,
                      const Text(
                        "ARE YOU A",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      25.cusSH,
                      ElevatedButton(
                        style: elevatedButtonStyles(),
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRouter.login,
                              arguments: isUser ? "User" : "Organization");
                        },
                        child: const Text(
                          "Organization",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      25.cusSH,
                      const Text(
                        "OR",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      25.cusSH,
                      ElevatedButton(
                        style: elevatedButtonStyles(),
                        onPressed: () {
                          setState(() {
                            isUser = true;
                          });
                          Navigator.of(context).pushNamed(AppRouter.login,
                              arguments: isUser ? "User" : "Organization");
                        },
                        child: const Text(
                          "User",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
  const ElevatedButtons({
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
        return ElevatedButton(
          style: elevatedButtonStyles(),
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
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
            ),
          ),
        );
      },
    );
  }
}
