import 'package:flutter/material.dart';

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
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 3,
          color: borderColor,
        ),
      ),
      child: CircleAvatar(
        radius: raduis,
        backgroundImage: NetworkImage(img),
      ),
    );
  }
}
