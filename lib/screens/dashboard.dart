import 'package:final_year_project/common/Extensions/custom_sizedbox.dart';
import 'package:final_year_project/screens/image_view.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
import 'package:final_year_project/widgets/dashboard_widgets/notices_stream.dart';
import 'package:final_year_project/widgets/dashboard_widgets/uploading-post_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../auth/controller/auth_controller.dart';
import '../utils/colors.dart';
import 'package:flutter/foundation.dart';
import '../widgets/dashboard_widgets/my_drawer.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthController>().appUser;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const NavBar(),
        body: Center(
          child: LayoutBuilder(
            builder: (context, constraint) {
              return constraint.maxWidth > 500
                  ? Row(
                      children: [
                        const NavBar(),
                        100.cusSW,
                        Column(
                          children: [
                            Container(
                              height: 210.h,
                              width: constraint.maxWidth > 500
                                  ? 700
                                  : screenWidth(context),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _scaffoldKey.currentState!
                                                .openDrawer();
                                          },
                                          icon: constraint.maxWidth > 500
                                              ? const SizedBox()
                                              : const Icon(
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
                                    user != null
                                        ? Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  showProfileImageDialog(
                                                      context,
                                                      context
                                                          .read<
                                                              AuthController>()
                                                          .appUser!
                                                          .profileUrl
                                                          .toString());
                                                },
                                                child: MyCircleAvatars(
                                                  borderColor:
                                                      AppColors.lightGreyColor,
                                                  raduis: kIsWeb ? 20 : 20.r,
                                                  img: user.profileUrl
                                                      .toString(),
                                                ),
                                              ),
                                              15.cusSW,
                                              Text(
                                                "Welcome!  ${user.name}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: kIsWeb ? 17 : 17.sp,
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
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          height: 210.h,
                          width: constraint.maxWidth > 500
                              ? 700
                              : screenWidth(context),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                30.cusSH,
                                context.read<AuthController>().appUser != null
                                    ? Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              showProfileImageDialog(
                                                  context,
                                                  context
                                                      .read<AuthController>()
                                                      .appUser!
                                                      .profileUrl
                                                      .toString());
                                            },
                                            child: MyCircleAvatars(
                                              borderColor:
                                                  AppColors.lightGreyColor,
                                              raduis: kIsWeb ? 30 : 35.r,
                                              img: context
                                                  .read<AuthController>()
                                                  .appUser!
                                                  .profileUrl
                                                  .toString(),
                                            ),
                                          ),
                                          15.cusSW,
                                          Text(
                                            "Welcome!  ${context.read<AuthController>().appUser!.name}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: kIsWeb ? 17 : 17.sp,
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
      ),
    );
  }
}

void showProfileImageDialog(BuildContext context, String view) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop(); // Close the dialog when tapped outside
        },
        child: Container(
          width: 600,
          height: 600,
          color: Colors.transparent, // Transparent background
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  view, // Replace with your image path
                  width: 500,
                  height: 500,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Check internet connection!');
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return CircularProgressIndicator();
                    } else {
                      return child;
                    }
                  },
                  //   fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
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
          width: constraint.maxWidth > 500 ? 700 : screenWidth(context) * 0.9,
          child: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: SizedBox(
              height: screenHeight(context),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
