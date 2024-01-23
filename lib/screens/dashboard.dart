import 'dart:developer';

import 'package:final_year_project/common/Extensions/custom_sizedbox.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
import 'package:final_year_project/widgets/dashboard_widgets/notices_stream.dart';
import 'package:final_year_project/widgets/dashboard_widgets/uploading-post_widgets.dart';
import 'package:flutter/foundation.dart';
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
    final user = context.read<AuthController>().appUser;
    return Scaffold(
      drawer: const NavBar(),
      key: _scaffoldKey,
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
                                                        .read<AuthController>()
                                                        .appUser!
                                                        .profileUrl
                                                        .toString());
                                              },
                                              child: MyCircleAvatars(
                                                borderColor:
                                                    AppColors.lightGreyColor,
                                                raduis: kIsWeb ? 20 : 20.r,
                                                img: user.profileUrl.toString(),
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
                        height: 200,
                        width: constraint.maxWidth > 500
                            ? 700
                            : screenWidth(context),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          color: Colors.blue.shade700,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              30.cusSH,
                              context.read<AuthController>().appUser != null
                                  ? Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              log('message');
                                              _scaffoldKey.currentState!
                                                  .openDrawer();
                                            },
                                            child: const Icon(
                                              Icons.menu,
                                              color: Colors.white,
                                            )),
                                        const SizedBox(
                                          width: 20,
                                        ),
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
                                          child: Padding(
                                            padding: const EdgeInsets.only(),
                                            child: MyCircleAvatars(
                                                borderColor: Colors.blue,
                                                raduis: kIsWeb ? 30 : 35.r,
                                                img: context
                                                    .read<AuthController>()
                                                    .appUser!
                                                    .profileUrl),
                                          ),
                                        ),
                                        15.cusSW,
                                        Text(
                                          "WELCOME  ${context.read<AuthController>().appUser!.name.toUpperCase()}",
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
                    return const Text('');
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const CircularProgressIndicator();
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
          width: constraint.maxWidth > 500 ? 700 : screenWidth(context) * 0.92,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UploadingPostWidget(),
              Expanded(
                child: NoticesStream(),
              ),
            ],
          ),
        );
      },
    );
  }
}
