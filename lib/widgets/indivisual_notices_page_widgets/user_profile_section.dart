import 'package:final_year_project/common/elevated_button_style.dart';
import 'package:final_year_project/models/user_post.dart';
import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/router/router.dart';
import '../../utils/colors.dart';

class UserProfileSection extends StatelessWidget {
  const UserProfileSection({
    required this.posts,
    Key? key,
  }) : super(key: key);
  final UserPosts posts;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          ListTile(
            leading: SizedBox(
              child: MyCircleAvatars(
                borderColor: Colors.black,
                img: posts.profilePicture.toString(),
                raduis: 30,
              ),
            ),
            title: Text(posts.name),
            subtitle: const Text("1.3M followers"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              children: [
                posts.uid == FirebaseAuth.instance.currentUser!.uid
                    ? ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            Size(200.w, 55.h),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            AppColors.blueColor,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRouter.chatScreen);
                        },
                        child: const Text("Message"),
                      )
                    : const SizedBox(),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
