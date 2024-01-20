import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/models/user_post.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
import 'package:final_year_project/widgets/dashboard_widgets/like_comments_and_share.dart';
import 'package:final_year_project/widgets/dashboard_widgets/notices_grid.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class NoticeBoardForNotices extends StatefulWidget {
  const NoticeBoardForNotices({
    required this.posts,
    Key? key,
  }) : super(key: key);
  final UserPosts posts;

  @override
  State<NoticeBoardForNotices> createState() => _NoticeBoardForNoticesState();
}

class _NoticeBoardForNoticesState extends State<NoticeBoardForNotices> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("posts")
            .where("uid", isEqualTo: widget.posts.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            final data = snapshot.data!.docs
                .map((e) => UserPosts.fromJson(e.data()))
                .toList();
            return SizedBox(
              width: screenWidth(context),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          AppRouter.indivisualNoticesPage,
                          arguments: widget.posts);
                    },
                    child: ListTile(
                      leading: MyCircleAvatars(
                        borderColor: AppColors.lightGreyColor,
                        raduis: 26,
                        img: widget.posts.profilePicture.toString(),
                      ),
                      title: Builder(builder: (context) {
                        if (screenWidth(context) > 50 &&
                            screenWidth(context) < 300) {
                          return Column(
                            children: [
                              Text(
                                widget.posts.name,
                              ),
                              const SizedBox(
                                width: 1,
                              ),
                              Text("(${widget.posts.uniqueId.toString()})"),
                            ],
                          );
                        } else {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  widget.posts.name,
                                ),
                                const SizedBox(
                                  width: 1,
                                ),
                                Text("(${widget.posts.uniqueId.toString()})"),
                              ],
                            ),
                          );
                        }
                      }),
                      subtitle: const Text('Recent Notices'),
                    ),
                  ),
                  NoticesGrid(
                    posts: data,
                    up: widget.posts,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: LikeCommentsAndShare(
                        posts: widget.posts,
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            const Text("No data found");
          }
          return const Center(child: Text(''));
        });
  }
}
