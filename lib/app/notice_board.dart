import 'package:final_year_project/app/router/router.dart';
import 'package:flutter/material.dart';

class NoticeBoard extends StatelessWidget {
  const NoticeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        return AppRouter.onGenerateRoute(settings);
      },
    );
  }
}
