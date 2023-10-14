import 'package:flutter/material.dart';

class LoadingController extends ChangeNotifier {
  bool isloading = false;
  void loading() {
    isloading = !isloading;
  notifyListeners();
  }

}
