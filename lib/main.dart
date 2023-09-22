import 'package:final_year_project/app/notice_board.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dotenv/dotenv.dart';

void main() async {
  DotEnv dotEnv = DotEnv();
  WidgetsFlutterBinding.ensureInitialized();
  kIsWeb
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyAP6VjxxVuPRunxTNGaveKgDQdqeBZTDkU",
              appId: "1:518430979356:web:8442e3e930327cca3e76d9",
              messagingSenderId: "518430979356",
              projectId: "final-year-project-91ce0"))
      : await Firebase.initializeApp();
  runApp(const NoticeBoard());
}
