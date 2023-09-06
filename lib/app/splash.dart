import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/common/controller/post_controller.dart';
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
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    Future.delayed(const Duration(seconds: 2), () async {
      final isCurrentUser =
          await context.read<AuthController>().checkCurrentUser(context);
      if (isCurrentUser != null) {
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
