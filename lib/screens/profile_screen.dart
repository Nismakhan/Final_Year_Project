import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/common/controller/post_controller.dart';
import 'package:final_year_project/screens/other_user_profile_screen.dart';
import 'package:final_year_project/utils/const.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/dashboard_widgets/notices_grid.dart';
import 'package:final_year_project/widgets/profile_screen_widgets/shared_post_grid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widgets/profile_screen_widgets/user_profile_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    tabContoller = TabController(length: 2, vsync: this);
    super.initState();
  }

  late TabController tabContoller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        // leading: const Icon(
        //   Icons.arrow_back,
        //   size: 30,
        // ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: MoreVertOutlined(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            SizedBox(
              width: screenWidth(context),
              child: UserProfileSection(
                user: context.read<AuthController>().appUser!,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Container(
            //   // color: Colors.grey,
            //   decoration: BoxDecoration(
            //     color: const Color.fromARGB(255, 228, 224, 224),
            //     borderRadius: BorderRadius.circular(10),
            //   ),

            //   width: screenWidth(context) * 0.7,
            //   // height: screenHeight(context),
            //   child: Padding(
            //     padding: const EdgeInsets.all(20.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: const [
            //         PhotosVediosAndTaggedSection(
            //           text: "Photos",
            //         ),
            //         PhotosVediosAndTaggedSection(
            //           text: "Vedios",
            //         ),
            //         PhotosVediosAndTaggedSection(
            //           text: "Tagged",
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 2,
            ),
            TabBar(
              labelColor: Colors.black,
              controller: tabContoller,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  text: "My Post",
                ),
                Tab(
                  text: "Shared Posts",
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabContoller,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Expanded(
                      child: Consumer<PostController>(
                          builder: (context, provider, _) {
                        switch (provider.state) {
                          case LoadingState.idle:
                            return const SizedBox();
                          case LoadingState.processing:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case LoadingState.error:
                            return const Center(
                              child: Text("Error"),
                            );
                          case LoadingState.loaded:
                            return NoticesGrid(
                              posts: provider.currentUserPosts,
                            );
                        }
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Expanded(
                        child: SharedPostGrid(
                      uid: FirebaseAuth.instance.currentUser!.uid,
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoreVertOutlined extends StatelessWidget {
  const MoreVertOutlined({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 250, 155, 148), width: 3),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.more_vert_outlined,
      ),
    );
  }
}
