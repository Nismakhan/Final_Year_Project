import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/models/notifications_model.dart';
import 'package:final_year_project/utils/colors.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/common/stack_circles.dart';
import 'package:final_year_project/widgets/notification_widget/notifications_bubble.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        foregroundColor: Colors.white,
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .orderBy('time', descending: true)
            .where('uid',
                isEqualTo: context.read<AuthController>().appUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          final data = snapshot.data?.docs
              .map((e) => NotificationModel.fromJson(e.data()))
              .toList();

          if (snapshot.connectionState == ConnectionState.waiting) {
            print('in');
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No Notifications'));
          }
          if (!snapshot.hasError) {
            return const Center(child: Text('No Network'));
          }
          print('length is ${data?.length ?? 'nothing'}');
          return SafeArea(
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
                        itemCount: data?.length ?? 0,
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
                                child: data!.isNotEmpty
                                    ? NotificationBubble(
                                        notify: data[index],
                                        // user: widget.user.,
                                        // body: notify!.body,
                                      )
                                    : const Center(
                                        child: Text(
                                        'kamal',
                                        style: TextStyle(color: Colors.black),
                                      )),
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
          );
        },
      ),
    );
  }
}
