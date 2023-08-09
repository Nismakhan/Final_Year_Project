import 'package:flutter/material.dart';

class UiController with ChangeNotifier {
  int currentIndex = 0;
  PageController pageCon = PageController(initialPage: 0);

  void changeCurrentIndex(int index) {
    currentIndex = index;
    pageCon.jumpToPage(
      currentIndex,
      // duration: const Duration(milliseconds: 200),
      // curve: Curves.easeIn,
    );
    notifyListeners();
  }
}
