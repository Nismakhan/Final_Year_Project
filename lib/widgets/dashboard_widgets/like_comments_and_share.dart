import 'package:final_year_project/models/user_post.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class LikeCommentsAndShare extends StatefulWidget {
  const LikeCommentsAndShare({
    required this.posts,
    Key? key,
  }) : super(key: key);
  final UserPosts posts;

  @override
  State<LikeCommentsAndShare> createState() => _LikeCommentsAndShareState();
}

class _LikeCommentsAndShareState extends State<LikeCommentsAndShare> {
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    print('i am rebuilding');
    return screenWidth(context) > 50 && screenWidth(context) < 300
        ? const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
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
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLike = !isLike;
                      });
                      // final like=LikeModel(likeId: posts.postId, uid: uid, userName: userName, dateAdded: dateAdded, postId: postId,)
                    },
                    child: isLike
                        ? const ImageIcon(
                            AssetImage('assets/images/like.png'),
                          )
                        : const ImageIcon(
                            AssetImage('assets/images/up.png'),
                          ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  const Text(
                    "Like",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blueColor),
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
