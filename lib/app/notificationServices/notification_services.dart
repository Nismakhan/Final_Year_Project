import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/auth/models/user_model.dart';
import 'package:final_year_project/common/controller/post_controller.dart';
import 'package:final_year_project/main.dart';
import 'package:final_year_project/models/notifications_model.dart';
import 'package:final_year_project/screens/notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:provider/provider.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';

class NotificationServices {
  late AuthController authController;

  NotificationServices() {
    initializeAuthController();
  }

  Future<void> initializeAuthController() async {
    authController = AuthController();
// Assuming you have an initialize method in AuthController
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initNotifications(BuildContext context, RemoteMessage message) async {
    var androidInitilize =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iOSInitilize = const DarwinInitializationSettings();
    var initilizationsSettings =
        InitializationSettings(android: androidInitilize, iOS: iOSInitilize);

    // var initializationSetting =
    //     InitializationSettings(android: androidInitilize, iOS: iOSInitilize);

    flutterLocalNotificationsPlugin.initialize(initilizationsSettings,
        onDidReceiveNotificationResponse: (payload) async {
      print('kimiiiiiiiiii');
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => UserNotifications()));
      // handleMessage(payload);
      // You could do navigation here

      handleMessage(context, message);

      //  showNotification(message);
      log('onSelectNotification: $payload');
      //showNotification(payload as RemoteMessage);
    });
  }

  Future<void> showNotification(
      RemoteMessage message, BuildContext context) async {
    String? image = message.data['image'];
    final String json = message.data['user'];
    UserModel user = UserModel.fromJson(jsonDecode(json));
    // print(image);

    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId ?? "defautl",
      message.notification!.android!.channelId ?? "defaulChannelId",
      importance: Importance.max,
      showBadge: true,
      playSound: true,
      // sound: const RawResourceAndroidNotificationSound('jetsons_doorbell'),
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: 'your channel description',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            ticker: 'ticker',
            // sound: channel.sound
            //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
            icon: "@mipmap/ic_launcher");

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var generalNotificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    final mynotification = NotificationModel(
      title: message.notification!.title!,
      body: message.notification!.body!,
      notificationId: const Uuid().v1(),
      uid: FirebaseAuth.instance.currentUser!.uid,
      time: Timestamp.now(),
      image: image ?? '', // Provide a default image URL
      user: user,
      // image: FirebaseAuth.instance.currentUser!.photoURL!
    );
    log('i am here');
    if (message.data['type'] == 'activation') {
      // log(image);
      log('succeess');
      // log(user.toString());
      navigator.currentContext!
          .read<PostController>()
          .uploadNotification(notification: mynotification);
    }
    // You could include the message.data in the AndroidNotificationDetails as a payload
    Future.delayed(Duration.zero, () {
      log("show messeage");
      flutterLocalNotificationsPlugin.show(
        1,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        generalNotificationDetails,
        // payload: message.notification!.android!.imageUrl.toString(),
      );
      print(
        message.notification!.android!.imageUrl.toString(),
      );
    });
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken(
        vapidKey:
            "AAAAeLTk9Rw:APA91bFicE2ZYhUK25U54MWgxfLqg677g7ABlDVNHcUEYMEcTlfRvaRQPiWBmeTBSpgE9n5OGIKsoLUyg-yQEJ3U3aNs2owcCnzGwo2FR3OAS2YyYRHWDubuEmfITITnJFe-8GVN8C41");
    return token!;
  }

  void handleInteractMessage(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('onMessage data: ${message.data}');
      }
      showNotification(message, context);
      initNotifications(context, message);

      // Handle the message received
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('onMessageOpenedApp data: ${message.data}');
      }
      print('there');
      handleMessage(context, message);
      // Handle the message when the app is opened from a terminated state
    });
  }

  void requestNotificationPermissions() {
    messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);
  }

  // Future<void> firebasebackgroundmessaginghandler(BuildContext context) async {
  //   FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
  //     if (kDebugMode) {
  //       print('onMessage data: ${message.data}');
  //     }
  //     showNotification(message, context);
  //     initNotifications(context, message);

  //     // Handle the message received
  //   });
  // }

  void handleForegroundMessage(BuildContext context) {
    log("m.........kekke");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print('A new onMessage event was published!');
      }
      // await showNotification(message, context);
    });
  }

  //handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      // ignore: use_build_context_synchronously
      handleMessage(context, initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('object');
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext ctx, RemoteMessage? message) {
    if (message == null) return;

    // final mynotification = NotificationModel(
    //   title: message.notification!.title!,
    //   body: message.notification!.body!,
    //   notificationId: const Uuid().v1(),
    //   uid: FirebaseAuth.instance.currentUser!.uid,
    //   // image: FirebaseAuth.instance.currentUser!.photoURL!
    // );
    // log('i am here');
    // if (message.data['type'] == 'activation') {
    //   log('succeess');
    //   ctx
    //       .read<ReportController>()
    //       .uploadNotification(notification: mynotification, context: ctx);
    //remove the below line and then check wether notification is uplopading or not
    navigator.currentState?.pushNamed(AppRouter.notifications);

    // .navigator
    // .currentState
    // ?.pushNamed(AppRouter.notifications, arguments: message);
    // if (message.notification != null) {
    //   print('kimiiiiiiiiii');
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => UserNotifications()));
    // showDialog(
    //   context: context,
    //   builder: ((BuildContext context) {
    //     return DynamicDialog(
    //       title: message.notification!.title,
    //       body: message.notification!.body,
    //       screen: message.data['notification'],
    //       parentContext: context,
    //       // Indicate that you want to navigate to a screen.
    //     );
    //   }),
    // );
    // }
    var messageType = message.data['type'];

    // if (messageType != null) {
    //   switch (messageType) {
    //     case 'machine':
    //       Navigator.pushNamed(context, AppRouter.receiverRequest);
    //       break;
    //     case 'activation':
    //       Navigator.pushNamed(context, AppRouter.dashBoard);
    //       break;
    //     // Add more cases if you have multiple types
    //     // case 'ANOTHER_TYPE':
    //     //   // Handle another type
    //     //   break;

    //     default:
    //       print('Unknown type $messageType');
    //   }
    // } else {
    //   print('No type field in the message data');
    // }
  }

  Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    log('ssssssssssssssssssssssss');
  }

  void messageListener(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Message also contained a notification: ${message.notification!.body}');
        // showDialog(
        //     context: context,
        //     builder: ((BuildContext context) {
        //       return DynamicDialog(
        //           parentContext: context,
        //           title: message.notification!.title,
        //           body: message.notification!.body);
        //     }));
      }
    });
  }

//   Future<void> remindMeLater({required int hoursLater}) async {

//   const androidPlatformChannelSpecifics = AndroidNotificationDetails(
//     'reminder_id',
//     'Reminders',
//     channelDescription: 'Reminder Notifications',
//     importance: Importance.max,
//     priority: Priority.high,
// );

//   final platformChannelSpecifics = NotificationDetails(
//     android: androidPlatformChannelSpecifics,
//     iOS: const DarwinNotificationDetails(),
//   );

//   await flutterLocalNotificationsPlugin.zonedSchedule(
//     0,
//     'Reminder',
//     'This is your reminder!',
//     tz.TZDateTime.now(tz.local).add(Duration(seconds: 30)),
//     platformChannelSpecifics,
//     // androidScheduleMode: AndroidScheduleMode.exact,
//     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//   );
// }
}

//push notification dialog for foreground
class DynamicDialog extends StatefulWidget {
  final title;
  final body;
  final screen;
  final BuildContext parentContext;
  DynamicDialog(
      {this.title, this.body, this.screen, required this.parentContext});
  @override
  _DynamicDialogState createState() => _DynamicDialogState();
}

class _DynamicDialogState extends State<DynamicDialog> {
  @override
  Widget build(BuildContext context) {
    print('in build');
    return AlertDialog(
      title: Text(widget.title),
      actions: <Widget>[
        OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            // icon: const Icon(Icons.close),
            child: Text('Close')),
        OutlinedButton(
            onPressed: () {
              Navigator.pop(context);

              if (widget.screen == '/notifications') {
                print('HIIIIIII');
                Navigator.push(
                  widget.parentContext,
                  MaterialPageRoute(
                    builder: (context) => UserNotifications(
                        // title: widget.title ?? " ",

                        ),
                  ),
                );
              }
            },
            // icon: const Icon(Icons.done),
            child: const Text('Open')),
      ],
      content: Text(widget.body),
    );
  }
}
