import 'package:flutter/material.dart';

class ThirdPartyIcons extends StatelessWidget {
  const ThirdPartyIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.facebook,
          size: 50,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: Icon(
            Icons.facebook,
            size: 50,
          ),
        ),
        Icon(
          Icons.facebook,
          size: 50,
        ),
      ],
    );
  }
}
