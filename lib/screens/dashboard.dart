import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/auth/widgets/my_buttions.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
import 'package:final_year_project/widgets/dashboard_widgets/notice_board_for_notices.dart';
import 'package:final_year_project/widgets/dashboard_widgets/notices_stream.dart';
import 'package:final_year_project/widgets/dashboard_widgets/uploading-post_widgets.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/dashboard_widgets/my_drawer.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.blueColor,
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
                // MyCircleAvatars(
                //     borderColor: AppColors.blueColor,
                //     img:
                //         "https://static.vecteezy.com/packs/media/vectors/term-bg-1-3d6355ab.jpg"),
              ],
            ),
          )
        ],
      ),
      drawer: const NavBar(),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return const DashboardBody();
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
        return Container(
          width: constraint.maxWidth > 500 ? 500 : screenWidth(context) * 0.9,
          child: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: screenHeight(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    UploadingPostWidget(),
                    Expanded(
                      child: NoticesStream(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
