import 'package:flutter/material.dart';

BoxDecoration decorationForTextFieldsContainers() {
  return BoxDecoration(
    color: const Color.fromARGB(255, 226, 226, 226),
    borderRadius: BorderRadius.circular(8),
  );
}

InputDecoration decorationForTextfields(
    {required String text, required IconData icon}) {
  return InputDecoration(
    suffixIcon: Icon(
      icon,
    ),
    labelText: text,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: const OutlineInputBorder(
      borderSide: BorderSide.none,
    ),
  );
}
