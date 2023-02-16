import 'package:flutter/material.dart';

class MyRadioButtons extends StatelessWidget {
  const MyRadioButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio(
          value: 1,
          groupValue: 1,
          onChanged: ((value) {}),
        ),
        const Text("Organization"),
        Radio(
          value: 2,
          groupValue: 2,
          onChanged: ((value) {}),
        ),
        const Text("Student"),
      ],
    );
  }
}
