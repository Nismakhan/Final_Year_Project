import 'package:flutter/material.dart';

class MyButtions extends StatelessWidget {
  const MyButtions({
    Key? key,
    required this.text,
    required this.onSelect,
    required this.width,
    required this.height,
    this.isloading = false,
  }) : super(key: key);
  final String text;
  final void Function()? onSelect;
  final double width;
  final double height;
  final bool isloading;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        gradient: LinearGradient(
          colors: [
            // Color.fromARGB(255, 239, 187, 248),
            Color.fromARGB(255, 207, 207, 207),
            Color.fromARGB(255, 73, 255, 79)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: OutlinedButton(
        onPressed: onSelect,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
