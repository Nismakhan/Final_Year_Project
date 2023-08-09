import 'package:final_year_project/screens/dashboard.dart';
import 'package:final_year_project/screens/explore.dart';
import 'package:final_year_project/screens/notifications_screen.dart';
import 'package:final_year_project/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/controller/ui_controller.dart';
import '../common/my_bottem_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const MyBottomNav(),
        body: Consumer<UiController>(builder: (context, provider, _) {
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: provider.pageCon,
            // onPageChanged: (value) {
            //   provider.changeCurrentIndex(value);
            // },
            children: [
              const Dashboard(),
              const ProfileScreen(),
              const Notifications(),
              Explore()
              // IndivisualPostPage(),
            ],
          );
        }));
  }
}
