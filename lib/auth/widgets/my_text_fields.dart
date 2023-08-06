import 'package:flutter/material.dart';

class MyTextFields extends StatelessWidget {
  const MyTextFields({
    Key? key,
    required this.text,
    required this.icons,
    this.regExp,
    this.errorText,
    this.emailcontroller,
  }) : super(key: key);
  final String text;
  final IconData icons;
  final String? regExp;
  final String? errorText;
  final TextEditingController? emailcontroller;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 226, 226, 226),
        borderRadius: BorderRadius.circular(20),
      ),
      width: 300,
      child: TextFormField(
        controller: emailcontroller,
        validator: ((value) {
          final expression = RegExp(regExp!);
          if (!expression.hasMatch(value!)) {
            return errorText;
          }
          return null;
        }),
        decoration: InputDecoration(
          suffixIcon: Icon(
            icons,
          ),
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
