import 'package:flutter/material.dart';

class MessagesContainer extends StatelessWidget {
  const MessagesContainer({
    Key? key,
    required this.text,
    this.clrForText,
    this.clrForBackground,
    required this.width,
    required this.height,
  }) : super(key: key);
  final String text;
  final Color? clrForText;
  final Color? clrForBackground;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: clrForBackground, borderRadius: BorderRadius.circular(19)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: clrForText,
          ),
        ),
      ),
    );
  }
}

class ChatScreenBottemWidgets extends StatelessWidget {
  const ChatScreenBottemWidgets({
    Key? key,
    this.clr,
    required this.icondata,
    required this.text,
  }) : super(key: key);
  final Color? clr;
  final IconData icondata;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 45,
          decoration: BoxDecoration(
            color: clr,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icondata,
            size: 35,
            color: Colors.white,
          ),
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
