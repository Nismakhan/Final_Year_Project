import 'package:flutter/material.dart';

class MyButtions extends StatelessWidget {
  const MyButtions({
    Key? key,
    required this.text,
    required this.onSelect,
  }) : super(key: key);
  final String text;
  final void Function()? onSelect;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        gradient: LinearGradient(
          colors: [
            // Color.fromARGB(255, 239, 187, 248),
            Color.fromARGB(255, 195, 190, 255),
            Color(0xFF6C63FF),
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
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
