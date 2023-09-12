import 'package:final_year_project/common/Extensions/custom_sizedbox.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
import 'package:final_year_project/widgets/dashboard_widgets/notices_stream.dart';
import 'package:final_year_project/widgets/dashboard_widgets/uploading-post_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../auth/controller/auth_controller.dart';
import '../utils/colors.dart';
import '../widgets/dashboard_widgets/my_drawer.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const NavBar(),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Column(
              children: [
                Container(
                  height: 210.h,
                  width: constraint.maxWidth > 500 ? 500 : screenWidth(context),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    color: AppColors.blueColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                _scaffoldKey.currentState!.openDrawer();
                              },
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.white,
                              ),
                            ),
                            const Icon(
                              Icons.notification_add_sharp,
                              color: Colors.white,
                            )
                          ],
                        ),
                        40.cusSH,
                        context.read<AuthController>().appUser != null
                            ? Row(
                                children: [
                                  MyCircleAvatars(
                                    borderColor: AppColors.lightGreyColor,
                                    raduis: 26,
                                    img: context
                                        .read<AuthController>()
                                        .appUser!
                                        .profileUrl
                                        .toString(),
                                  ),
                                  15.cusSW,
                                  Text(
                                    "Welcome!  ${context.read<AuthController>().appUser!.name}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            : const CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ),
                const Expanded(child: DashboardBody()),
              ],
            );
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
          child: Padding(
            padding: const EdgeInsets.only(top: 18.0),
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
        );
      },
    );
  }
}
