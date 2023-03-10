import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
import 'package:final_year_project/widgets/dashboard_widgets/my_drawer.dart';
import 'package:final_year_project/widgets/indivisual_notices_page_widgets/indivisual_post_section.dart';
import 'package:final_year_project/widgets/indivisual_notices_page_widgets/user_profile_section.dart';
import 'package:flutter/material.dart';

class IndivisualNoticesPage extends StatelessWidget {
  const IndivisualNoticesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              return SizedBox(
                width: constraint.maxHeight < 500 ? screenWidth(context) : 700,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const UserProfileSection(),
                      const Divider(
                        thickness: 3,
                        // height: 20,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const Text("Home"),
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Text("About"),
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Text("Social links"),
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Text("Vedios"),
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
                        child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: ((context, index) {
                              return const Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: IndividualPostSection(),
                              );
                            })),
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
  }
}
