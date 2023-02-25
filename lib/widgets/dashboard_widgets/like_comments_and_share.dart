import 'package:flutter/material.dart';

class LikeCommentsAndShare extends StatelessWidget {
  const LikeCommentsAndShare({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Icon(
              Icons.thumb_up,
              size: 30,
            ),
            SizedBox(
              width: 7,
            ),
            Text(
              "Like",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: const [
            Icon(
              Icons.chat_bubble_outline,
              size: 30,
            ),
            SizedBox(
              width: 7,
            ),
            Icon(
              Icons.share,
              size: 30,
            ),
          ],
        )
      ],
    );
  }
}
