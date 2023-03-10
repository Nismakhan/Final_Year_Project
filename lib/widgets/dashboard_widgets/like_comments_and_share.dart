import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:flutter/material.dart';

class LikeCommentsAndShare extends StatelessWidget {
  const LikeCommentsAndShare({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return screenWidth(context) > 50 && screenWidth(context) < 300
        ? Column(
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
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRouter.comments);
                    },
                    child: const Icon(
                      Icons.chat_bubble_outline,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  const Icon(
                    Icons.share,
                    size: 30,
                  ),
                ],
              )
            ],
          )
        : Row(
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
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRouter.comments);
                    },
                    child: const Icon(
                      Icons.chat_bubble_outline,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  const Icon(
                    Icons.share,
                    size: 30,
                  ),
                ],
              )
            ],
          );
  }
}
