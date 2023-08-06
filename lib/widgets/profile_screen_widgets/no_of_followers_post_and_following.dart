import 'package:flutter/material.dart';

class NoOfFollowersPostAndFollowings extends StatelessWidget {
  NoOfFollowersPostAndFollowings({
    Key? key,
    required this.counting,
    required this.text,
    this.onpressed,
  }) : super(key: key);
  final String counting;
  final String text;
  void Function()? onpressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onpressed?.call();
      },
      child: Column(
        children: [
          Text(
            counting,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
