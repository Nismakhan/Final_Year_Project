import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/models/user_post.dart';
import 'package:final_year_project/widgets/dashboard_widgets/notice_board_for_notices.dart';
import 'package:flutter/material.dart';

class NoticesStream extends StatelessWidget {
  const NoticesStream({super.key});

  @override
  Widget build(BuildContext context) {
    print('like');
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection("posts")
          .orderBy("dateAdded", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return const SizedBox();
        }

        final data = snapshot.data!.docs;
        final Map<String, UserPosts> recentPosts = {};

        for (var doc in data) {
          final postData = doc.data();
          final post = UserPosts.fromJson(postData);
          final uid = post.uid;

          if (!recentPosts.containsKey(uid) ||
              post.dateAdded.compareTo(recentPosts[uid]!.dateAdded) > 0) {
            recentPosts[uid] = post;
          }
        }

        final List<UserPosts> recentPostsList = recentPosts.values.toList();
        log("Changed Data ${recentPostsList.toString()}");

        return ListView.builder(
          shrinkWrap: true,
          itemCount: recentPostsList.length,
          itemBuilder: (context, index) {
            return NoticeBoardForNotices(posts: recentPostsList[index]);
          },
        );
      },
    );
  }
}
