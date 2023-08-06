import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/common/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoticeBoard extends StatelessWidget {
  const NoticeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => AuthController()),
        ),
        ChangeNotifierProvider(
          create: ((context) => PostController()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          return AppRouter.onGenerateRoute(settings);
        },
      ),
    );
  }
}
