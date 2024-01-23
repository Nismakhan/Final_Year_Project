import 'package:final_year_project/app/notificationServices/notification_services.dart';
import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/common/controller/post_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    NotificationServices notificationServices = NotificationServices();
    notificationServices.handleInteractMessage(context);
    notificationServices.requestNotificationPermissions();
    notificationServices.handleForegroundMessage(context);
    //notificationServices.flutterLocalNotificationsPlugin;
    notificationServices.setupInteractMessage(context);
    notificationServices.forgroundMessage();
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    Future.delayed(const Duration(seconds: 3), () async {
      final isCurrentUser =
          await context.read<AuthController>().checkCurrentUser(context);
      if (isCurrentUser != null && isCurrentUser.emailVerified) {
        Navigator.of(context).pushReplacementNamed(AppRouter.homeScreen);
        context
            .read<PostController>()
            .getCurrentUsersPosts(uid: isCurrentUser.uid);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRouter.onboarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
