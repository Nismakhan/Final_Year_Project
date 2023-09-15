import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/models/user_post.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
import 'package:final_year_project/widgets/dashboard_widgets/my_drawer.dart';
import 'package:final_year_project/widgets/indivisual_notices_page_widgets/indivisual_post_section.dart';
import 'package:final_year_project/widgets/indivisual_notices_page_widgets/user_profile_section.dart';

import 'package:flutter/material.dart';

class IndivisualNoticesPage extends StatefulWidget {
  const IndivisualNoticesPage({
    super.key,
    required this.posts,
  });

  @override
  State<IndivisualNoticesPage> createState() => _IndivisualNoticesPageState();
  final UserPosts posts;
}

class _IndivisualNoticesPageState extends State<IndivisualNoticesPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  late TabController tabController;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("posts")
            .where("uid", isEqualTo: widget.posts.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!.docs
              .map((e) => UserPosts.fromJson(e.data() as Map<String, dynamic>))
              .toList();
          if (snapshot.hasError) {
            return const Text('Error');
          }
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                elevation: 0,
                title: const Icon(Icons.search),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyCircleAvatars(
                            borderColor: Colors.black,
                            img: widget.posts.profilePicture.toString()),
                      ],
                    ),
                  )
                ],
              ),
              drawer: const NavBar(),
              body: Center(
                child: LayoutBuilder(
                  builder: (context, constraint) {
                    return SizedBox(
                      width: constraint.maxHeight < 500
                          ? screenWidth(context)
                          : 700,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UserProfileSection(
                              posts: widget.posts,
                            ),
                            const Divider(
                              thickness: 3,
                              // height: 20,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TabBar(
                              controller: tabController,
                              labelColor: Colors.black,
                              indicatorWeight: 3,
                              indicatorSize: TabBarIndicatorSize.label,
                              tabs: const [
                                Tab(
                                  text: "Home",
                                ),
                                Tab(
                                  text: "About",
                                ),
                                Tab(
                                  text: "Socail Likns",
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              thickness: 3,
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: tabController,
                                children: [
                                  ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: ((context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: IndividualPostSection(
                                          post: data[index],
                                        ),
                                      );
                                    }),
                                  ),
                                  const Text("hhhh"),
                                  const Text("ddddd"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
