import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotenv/dotenv.dart';
import 'package:final_year_project/app/notice_board.dart';
import 'package:final_year_project/app/notificationServices/notification_services.dart';
import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/auth/models/user_model.dart';
import 'package:final_year_project/common/controller/post_controller.dart';
import 'package:final_year_project/models/notifications_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

final navigator = GlobalKey<NavigatorState>();
PostController? postController;
AuthController? authController;
NotificationServices notificationServices = NotificationServices();
Future main() async {
  DotEnv dotEnv = DotEnv();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    kIsWeb
        ? await Firebase.initializeApp(
            options: const FirebaseOptions(
                apiKey: "AIzaSyAP6VjxxVuPRunxTNGaveKgDQdqeBZTDkU",
                appId: "1:518430979356:web:8442e3e930327cca3e76d9",
                messagingSenderId: "518430979356",
                projectId: "final-year-project-91ce0"))
        : await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(firebasebackgroundmessaginghandler);
    runApp(const NoticeBoard());
  } catch (e) {
    print("Firebase initialization faileeeeed: $e");
  }
}

@pragma('vm:entry-point')
Future<void> firebasebackgroundmessaginghandler(RemoteMessage message) async {
  postController = PostController();
  authController = AuthController();
  if (kDebugMode) {
    String? image = message.data['image'];
    final String json = message.data['user'];
    UserModel user = UserModel.fromJson(jsonDecode(json));
    final mynotification = NotificationModel(
      title: message.notification!.title!,
      body: message.notification!.body!,
      notificationId: const Uuid().v1(),
      uid: FirebaseAuth.instance.currentUser!.uid,
      time: Timestamp.now(),
      user: user,
      image: image ?? '',
      // image: FirebaseAuth.instance.currentUser!.photoURL!
    );
    log('i am here');
    if (message.data['type'] == 'activation') {
      log('succeess');
      // ignore: use_build_context_synchronously
      if (postController != null) {
        await postController!.uploadNotification(notification: mynotification);
      }
      print('done');
    }
    print('here');
    print('that the background${message.notification!.title}');
  }
}
