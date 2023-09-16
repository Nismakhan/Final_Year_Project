import 'package:final_year_project/common/controller/ui_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

class MyBottomNav extends StatefulWidget {
  const MyBottomNav({
    Key? key,
  }) : super(key: key);

  @override
  State<MyBottomNav> createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UiController>(builder: (context, provider, _) {
      return Container(
        child: BottomNavigationBar(
          unselectedItemColor: AppColors.lightGreyColor,
          selectedItemColor: AppColors.blueColor,
          iconSize: 35,
          currentIndex: provider.currentIndex,
          onTap: (value) {
            provider.changeCurrentIndex(value);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "About",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "Explore",
            ),
          ],
        ),
      );
    });
  }
}
