import 'package:flutter/material.dart';

BoxDecoration decorationForTextFieldsContainers() {
  return BoxDecoration(
    color: const Color.fromARGB(255, 226, 226, 226),
    borderRadius: BorderRadius.circular(8),
  );
}

InputDecoration decorationForTextfields(
    {required String text, required IconData icon, IconData? suffix, Function()? onTap}) {
  return InputDecoration(
    prefixIcon: Icon(
      icon,
    ),
    suffixIcon: GestureDetector(
      onTap: onTap,
      child: Icon(suffix)),
    labelText: text,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: const OutlineInputBorder(
      borderSide: BorderSide.none,
    ),
  );
}
