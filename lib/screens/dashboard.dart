import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
import 'package:final_year_project/widgets/dashboard_widgets/notice_board_for_notices.dart';
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
      drawer: const NavBar(),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return constraint.maxWidth < 600
                ? const DashboardBody()
                : ListView(
                    shrinkWrap: false,
                    scrollDirection: Axis.horizontal,
                    children: [
                        Row(
                          children: const [
                            NavBar(),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 250.0,
                                right: 250,
                              ),
                              child: DashboardBody(),
                            ),
                            SideBar(),
                          ],
                        ),
                      ]);
          },
        ),
      ),
    );
  }
}

class DashboardBody extends StatelessWidget {
  const DashboardBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SizedBox(
          width: constraint.maxWidth > 500 ? 500 : screenWidth(context) * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.storyview);
                  },
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: MyCircleAvatars(
                          borderColor: Colors.green,
                          raduis: 30,
                          img:
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSP1DhX9FevEWM9cGBMaVZ_l706wTbEYbTl8g&usqp=CAU",
                        ),
                      );
                    },
                  ),
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
      },
    );
  }
}
