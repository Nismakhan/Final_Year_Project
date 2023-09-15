import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCircleAvatars extends StatelessWidget {
  const MyCircleAvatars({
    required this.borderColor,
    required this.img,
    this.raduis,
    Key? key,
  }) : super(key: key);
  final String img;
  final Color borderColor;
  final double? raduis;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 2,
              color: borderColor,
            ),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: raduis,
            backgroundImage: value.appUser!.profileUrl != null
                ? NetworkImage(img)
                : const AssetImage("assets/images/user.png") as ImageProvider,
          ),
        );
      },
    );
  }
}
