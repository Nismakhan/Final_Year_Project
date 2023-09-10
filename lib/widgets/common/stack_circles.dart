import 'package:final_year_project/utils/colors.dart';
import 'package:flutter/material.dart';

class StackCirlcles extends StatelessWidget {
  const StackCirlcles({
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.blueColor, shape: BoxShape.circle),
      width: width,
      height: height,
      child: const SizedBox(
        width: 100,
      ),
    );
  }
}
