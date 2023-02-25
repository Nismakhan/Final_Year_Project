import 'dart:ui';

import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
import 'package:final_year_project/widgets/dashboard_widgets/like_comments_and_share.dart';
import 'package:final_year_project/widgets/dashboard_widgets/notice_board_for_notices.dart';
import 'package:final_year_project/widgets/dashboard_widgets/notices_grid.dart';

import 'package:flutter/material.dart';

import '../widgets/dashboard_widgets/my_drawer.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Icon(Icons.search),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(
                  Icons.notifications,
                  size: 35,
                ),
                MyCircleAvatars(
                    borderColor: Colors.black,
                    img:
                        "https://static.vecteezy.com/packs/media/vectors/term-bg-1-3d6355ab.jpg"),
              ],
            ),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            flex: 1,
            child: MyCircleAvatars(
              borderColor: Colors.green,
              raduis: 30,
              img:
                  "https://static.vecteezy.com/packs/media/vectors/term-bg-1-3d6355ab.jpg",
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: NoticeBoardForNotices(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
