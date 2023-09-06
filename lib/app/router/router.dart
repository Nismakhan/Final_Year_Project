import 'package:final_year_project/auth/screens/forgot_password.dart';
import 'package:final_year_project/auth/screens/login.dart';
import 'package:final_year_project/auth/screens/sign_up.dart';
import 'package:final_year_project/app/splash.dart';
import 'package:final_year_project/models/user_post.dart';
import 'package:final_year_project/screens/chat_screen.dart';
import 'package:final_year_project/screens/comments.dart';
import 'package:final_year_project/screens/dashboard.dart';
import 'package:final_year_project/screens/followers_screen.dart';
import 'package:final_year_project/screens/following_screen.dart';
import 'package:final_year_project/screens/home_screen.dart';
import 'package:final_year_project/screens/indivisual_notices_page.dart';
import 'package:final_year_project/screens/onboarding.dart';
import 'package:final_year_project/screens/other_user_profile_screen.dart';
import 'package:final_year_project/screens/profile_screen.dart';
import 'package:final_year_project/screens/story_view.dart';

import 'package:flutter/material.dart';

import '../../screens/message_screen.dart';
import '../../screens/user_orginization.dart';

class AppRouter {
  static const String splash = "/";
  static const String onboarding = "/onboarding";
  static const String login = "/login";
  static const String signUp = "/sign_up";
  static const String dashboard = "/dashboard";
  static const String storyview = "/story_view";
  static const String indivisualNoticesPage = "/indivisual_notices_page";
  static const String comments = "/comments";
  static const String forgotPassword = "/forgot_password";
  static const String followersScreen = "/followersScreen";
  static const String followingScreen = "/followingScreen";
  static const String profileScreen = "/profile_screen";
  static const String otherUserprofileScreen = "/otherUserprofileScreen";
  static const String homeScreen = "/homeScreen";
  static const String messagesScreen = "/messages_screen";
  static const String chatScreen = "/chatScreen";
  static const String userOrganization = "/userOrganization";

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: ((context) => const Splash()),
        );
      case onboarding:
        return MaterialPageRoute(
          builder: ((context) => const Onboarding()),
        );
      case login:
        final args = settings.arguments as String;
        return MaterialPageRoute(
            builder: ((context) => Login(
                  type: args,
                )));
      case signUp:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: ((context) => SignUp(
                type: args,
              )),
        );
      case dashboard:
        return MaterialPageRoute(
          builder: ((context) => const Dashboard()),
        );
      case storyview:
        return MaterialPageRoute(
          builder: ((context) => StoriesView()),
        );
      case indivisualNoticesPage:
        final args = settings.arguments as UserPosts;
        return MaterialPageRoute(
          builder: ((context) => IndivisualNoticesPage(
                posts: args,
              )),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: ((context) => const HomeScreen()),
          settings: settings,
        );

      case followersScreen:
        final uid = settings.arguments as String;
        return MaterialPageRoute(
          builder: ((context) => FollowersScreen(
                uid: uid,
              )),
          settings: settings,
        );
      case followingScreen:
        final uid = settings.arguments as String;
        return MaterialPageRoute(
          builder: ((context) => FollowingScreen(
                uid: uid,
              )),
          settings: settings,
        );
      case comments:
        final args = settings.arguments as CommentArgs;
        return MaterialPageRoute(
          builder: ((context) => Comments(
                post: args.post,
              )),
        );
      case profileScreen:
        return MaterialPageRoute(
          builder: ((context) => const ProfileScreen()),
          settings: settings,
        );
      case otherUserprofileScreen:
        final args = settings.arguments as OtherUserProfileArgs;
        return MaterialPageRoute(
          builder: ((context) => OtherUserProfileScreen(
                args: args,
              )),
          settings: settings,
        );
      case forgotPassword:
        return MaterialPageRoute(
          builder: ((context) => const ForgotPassward()),
        );
      case messagesScreen:
        final args = settings.arguments as MessageScreenArgs;
        return MaterialPageRoute(
          builder: ((context) => MessageScreen(
                args: args,
              )),
          settings: settings,
        );
      case chatScreen:
        return MaterialPageRoute(
          builder: ((context) => ChatScreen()),
          settings: settings,
        );
      case userOrganization:
        return MaterialPageRoute(
          builder: ((context) => const UserOrganization()),
          settings: settings,
        );
    }
    return null;
  }
}
