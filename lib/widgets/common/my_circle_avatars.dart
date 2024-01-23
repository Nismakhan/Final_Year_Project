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
  final String? img;
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
              width: 1,
              color: borderColor,
            ),
          ),
          child: CircleAvatar(
            // backgroundColor: Colors.transparent,
            radius: raduis,
            backgroundImage: img != null && img!.isNotEmpty
                ? Image.network(img!,
                    loadingBuilder: (context, child, loadingProgress) {
                    print('object');
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  }).image
                : const AssetImage("assets/images/user.png"),
          ),
        );
      },
    );
  }
}
