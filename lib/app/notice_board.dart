import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/common/controller/chat_controller.dart';
import 'package:final_year_project/common/controller/post_controller.dart';
import 'package:final_year_project/common/controller/ui_controller.dart';
import 'package:final_year_project/screens/chat.dart';
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
        ChangeNotifierProvider(
          create: ((context) => UiController()),
        ),
        ChangeNotifierProvider(
          create: ((context) => ChatController()),
        ),
      ],
      child: MaterialApp(
        // home: const Chats(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          return AppRouter.onGenerateRoute(settings);
        },
      ),
    );
  }
}
