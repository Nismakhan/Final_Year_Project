import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/models/notifications_model.dart';
import 'package:final_year_project/utils/colors.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationBubble extends StatelessWidget {
  const NotificationBubble({
    required this.notify,
    super.key,
  });
  final NotificationModel notify;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 15,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 150, 206, 252),
        ),
        width: screenWidth(context),
        height: 70,
        child: Center(
          child: ListTile(
              onTap: () async {
                // context
                //     .read<AuthController>()
                //     .isUserFollowing(uid: notify.user.uid)
                //     .then((value) {
                //   print(value);
                // });
                // await context
                //         .read<AuthController>()
                //         .isUserFollowing(uid: notify.user.uid)
                //     ? Navigator.of(context).pushNamed(
                //         AppRouter.otherUserprofileScreen,
                //         arguments: notify.user,
                //       )
                //     // ignore: use_build_context_synchronously
                //     : ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                //         backgroundColor: AppColors.blueColor,
                //         content: Text("Private Reports")));
                // // Navigator.of(context)
                // //     .pushNamed(AppRouter.quickAccess, arguments: notify.user);
              },
              leading: CircleAvatar(
                radius: 30,
                child: Icon(Icons.person),
              ),
              title: Text(
                notify.title.toUpperCase(),
              ),
              subtitle: Text(notify.body),
              trailing: Text(timeago.format(notify.time.toDate()))),
        ),
        // child: Row(
        //   children: [
        //     const Icon(
        //       Icons.person,
        //       size: 28,
        //       color: Colors.white,
        //     ),
        //     const SizedBox(
        //       width: 8,
        //     ),
        //     Expanded(
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             notify.title.toString(),
        //             style: const TextStyle(fontSize: 18, color: Colors.white),
        //             overflow: TextOverflow.ellipsis,
        //             maxLines: 4,
        //           ),
        //           Text(
        //             notify.body.toString(),
        //             style: const TextStyle(fontSize: 18, color: Colors.white),
        //             overflow: TextOverflow.ellipsis,
        //             maxLines: 4,
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
