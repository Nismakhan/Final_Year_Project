import 'package:final_year_project/app/router/router.dart';
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
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AppRouter.indivisualNoticesPage);
            },
            child: ListTile(
              leading: const MyCircleAvatars(
                  borderColor: Colors.black,
                  raduis: 26,
                  img:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSP1DhX9FevEWM9cGBMaVZ_l706wTbEYbTl8g&usqp=CAU"),
              title: Builder(builder: (context) {
                if (screenWidth(context) > 50 && screenWidth(context) < 300) {
                  return Column(
                    children: const [
                      Text(
                        "City University",
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      Text("(100090)"),
                    ],
                  );
                } else {
                  return Row(
                    children: const [
                      Text(
                        "City University",
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      Text("(100090)"),
                    ],
                  );
                }
              }),
              subtitle: const Text('Recent Notices'),
            ),
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
