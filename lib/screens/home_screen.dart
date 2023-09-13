import 'package:final_year_project/screens/dashboard.dart';
import 'package:final_year_project/screens/explore.dart';
import 'package:final_year_project/screens/notifications_screen.dart';
import 'package:final_year_project/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/controller/ui_controller.dart';
import '../common/my_bottem_nav.dart';
import '../utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: Theme(
                data: Theme.of(context).copyWith(
                    canvasColor: const Color.fromARGB(255, 235, 235, 235)),
                child: const MyBottomNav())),
      ),
      body: Consumer<UiController>(builder: (context, provider, _) {
        return PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: provider.pageCon,
          // onPageChanged: (value) {
          //   provider.changeCurrentIndex(value);
          // },
          children: [
            Dashboard(),
            const ProfileScreen(),
            const Notifications(),
            Explore()
            // IndivisualPostPage(),
          ],
        );
      }),
    );
  }
}
