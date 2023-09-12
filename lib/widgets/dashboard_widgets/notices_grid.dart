import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/models/user_post.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class NoticesGrid extends StatefulWidget {
  const NoticesGrid({
    required this.posts,
    this.up,
    Key? key,
  }) : super(key: key);
  final List<UserPosts>? posts;
  final UserPosts? up;

  @override
  State<NoticesGrid> createState() => _NoticesGridState();
}

class _NoticesGridState extends State<NoticesGrid> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("posts")
            .where("uid", isEqualTo: widget.up!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final data = snapshot.data!.docs
                .map((e) => UserPosts.fromJson(e.data()))
                .toList();
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Colors.black,
              elevation: 6,
              color: Color.fromARGB(255, 245, 240, 240),
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return SizedBox(
                    height: screenHeight(context) * 0.44,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: GridView.builder(
                          // itemCount: posts.postId.length <= 4 ? posts.postId.length : 4,
                          itemCount: widget.posts!.length <= 4
                              ? widget.posts!.length
                              : 4,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    AppRouter.indivisualNoticesPage,
                                    arguments: widget.up);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                elevation: 6.6,
                                color: Colors.white,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.posts![index].about.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: AppColors.lightGreyColor),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
