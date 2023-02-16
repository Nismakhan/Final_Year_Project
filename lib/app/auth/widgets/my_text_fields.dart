import 'package:flutter/material.dart';

class MyTextFields extends StatelessWidget {
  const MyTextFields({
    Key? key,
    required this.text,
    required this.icons,
  }) : super(key: key);
  final String text;
  final IconData icons;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 226, 226, 226),
        borderRadius: BorderRadius.circular(20),
      ),
      width: 300,
      child: TextFormField(
        decoration: InputDecoration(
          suffixIcon: Icon(icons),
          labelText: text,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
