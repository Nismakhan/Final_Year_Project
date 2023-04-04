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
      decoration:
          const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
      width: width,
      height: height,
      child: const SizedBox(
        width: 100,
      ),
    );
  }
}
