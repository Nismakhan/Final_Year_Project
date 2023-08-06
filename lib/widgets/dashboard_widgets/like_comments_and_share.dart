import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/models/user_post.dart';
import 'package:final_year_project/screens/comments.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:flutter/material.dart';

class LikeCommentsAndShare extends StatelessWidget {
  const LikeCommentsAndShare({
    required this.posts,
    Key? key,
  }) : super(key: key);
  final UserPosts posts;
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
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Row(
              //   children: [
              //     InkWell(
              //       onTap: () {
              //         Navigator.pushNamed(context, AppRouter.comments,
              //             arguments: CommentArgs(post: posts));
              //       },
              //       child: const Icon(
              //         Icons.abc,
              //         size: 30,
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 7,
              //     ),
              //     const Icon(
              //       Icons.share,
              //       size: 30,
              //     ),
              //   ],
              // )
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
              // Row(
              //   children: [
              //     InkWell(
              //       onTap: () {
              //         Navigator.pushNamed(context, AppRouter.comments,
              //             arguments: CommentArgs(post: posts));
              //       },
              //       child: const Icon(
              //         Icons.chat_bubble_outline,
              //         size: 30,
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 7,
              //     ),
              //     const Icon(
              //       Icons.share,
              //       size: 30,
              //     ),
              //   ],
              // )
            ],
          );
  }
}
