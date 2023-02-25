import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
import 'package:final_year_project/widgets/dashboard_widgets/like_comments_and_share.dart';
import 'package:final_year_project/widgets/dashboard_widgets/notices_grid.dart';
import 'package:flutter/material.dart';

class NoticeBoardForNotices extends StatelessWidget {
  const NoticeBoardForNotices({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth(context),
      child: Column(
        children: [
          ListTile(
            leading: const MyCircleAvatars(
                borderColor: Colors.black,
                raduis: 26,
                img:
                    "https://static.vecteezy.com/packs/media/vectors/term-bg-1-3d6355ab.jpg"),
            title: Row(
              children: const [
                Text("City University"),
                SizedBox(
                  width: 3,
                ),
                Text("(100090)"),
              ],
            ),
            subtitle: const Text('Recent Notices'),
          ),
          const NoticesGrid(),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 50,
            ),
            child: LikeCommentsAndShare(),
          )
        ],
      ),
    );
  }
}
