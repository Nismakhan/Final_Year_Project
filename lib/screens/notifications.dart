import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/common/controller/post_controller.dart';
import 'package:final_year_project/models/notifications_model.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/common/stack_circles.dart';
import 'package:final_year_project/widgets/notification_widget/notifications_bubble.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class UserNotifications extends StatefulWidget {
  const UserNotifications({
    super.key,
    this.notify,
  });
  final NotificationModel? notify;

  @override
  State<UserNotifications> createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
  late List<NotificationModel>? userNotifications;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
    super.initState();
  }

  // final RemoteMessage? message;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          final data = snapshot.data?.docs
              .map((e) => NotificationModel.fromJson(e.data()))
              .toList();
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('in');
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          print('length is ${data!.length}');
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,

              // actions: [Icon(icon)],

              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.notifications,
                    size: 35,
                  ),
                ),
              ],
              title: const Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: LayoutBuilder(
                  builder: (p0, p1) {
                    return Stack(
                      children: [
                        p1.maxWidth > 550
                            ? Positioned(
                                top: -30,
                                left: -35,
                                child: StackCirlcles(
                                  width: screenWidth(context) * 0.27,
                                  height: screenHeight(context) * 0.27,
                                ),
                              )
                            : const SizedBox(),
                        p1.maxWidth > 550
                            ? Positioned(
                                bottom: -20,
                                right: -50,
                                child: StackCirlcles(
                                  width: screenWidth(context) * 0.27,
                                  height: screenHeight(context) * 0.27,
                                ),
                              )
                            : const SizedBox(),
                        ListView.builder(
                          itemCount: data!.length ?? 0,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: NotificationBubble(
                                    notify: data[index],
                                    // user: widget.user.,
                                    // body: notify!.body,
                                  ),
                                )
                                // : const Center(
                                //     child:
                                //         Text('Do Not Have Notifications yet'),
                                //   ),
                              ],
                            );
                          },
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
