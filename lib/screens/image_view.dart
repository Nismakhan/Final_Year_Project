import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key, required this.view});
  final String view;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: AlertDialog(
        content: Image.network(view),
      ),
    );
  }
}
