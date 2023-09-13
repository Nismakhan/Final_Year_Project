import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/auth/screens/sign_up.dart';
import 'package:final_year_project/common/controller/chat_controller.dart';
import 'package:final_year_project/common/controller/post_controller.dart';
import 'package:final_year_project/common/controller/ui_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../auth/controller/loading_controller.dart';

class NoticeBoard extends StatelessWidget {
  const NoticeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(425, 926),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: ((context) => AuthController()),
            ),
            ChangeNotifierProvider(
              create: ((context) => PostController()),
            ),
            ChangeNotifierProvider(
              create: ((context) => UiController()),
            ),
            ChangeNotifierProvider(
              create: ((context) => ChatController()),
            ),
            ChangeNotifierProvider(
              create: ((context) => LoadingController()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (settings) {
              return AppRouter.onGenerateRoute(settings);
            },
          ),
        );
      },
    );
  }
}
