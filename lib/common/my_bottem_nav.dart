import 'package:final_year_project/common/controller/ui_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      return BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.red,
        iconSize: 35,
        currentIndex: provider.currentIndex,
        onTap: (value) {
          provider.changeCurrentIndex(value);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "",
          ),
        ],
      );
    });
  }
}
