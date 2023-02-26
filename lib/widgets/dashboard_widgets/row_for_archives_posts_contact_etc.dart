import 'package:flutter/material.dart';

class RowForArchivesPostsContactEtc extends StatelessWidget {
  const RowForArchivesPostsContactEtc({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: textStyleForEveryText(),
          ),
        ],
      ),
    );
  }

  TextStyle textStyleForEveryText() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }
}
