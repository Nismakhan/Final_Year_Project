import 'package:final_year_project/app/auth/screens/login.dart';
import 'package:final_year_project/app/auth/screens/sign_up.dart';
import 'package:final_year_project/app/splash.dart';
import 'package:final_year_project/screens/dashboard.dart';
import 'package:final_year_project/screens/story_view.dart';

import 'package:flutter/material.dart';

class AppRouter {
  static const String splash = "/";
  static const String login = "/login";
  static const String signUp = "/sign_up";
  static const String dashboard = "/dashboard";
  static const String storyview = "/story_view";

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: ((context) => const Splash()),
        );
      case login:
        return MaterialPageRoute(
          builder: ((context) => Login()),
        );
      case signUp:
        return MaterialPageRoute(
          builder: ((context) => const SignUp()),
        );
      case dashboard:
        return MaterialPageRoute(
          builder: ((context) => const Dashboard()),
        );
      case storyview:
        return MaterialPageRoute(
          builder: ((context) => StoriesView()),
        );
    }
    return null;
  }
}
