import 'dart:developer';

import 'package:final_year_project/auth/models/user_model.dart';
import 'package:final_year_project/common/controller/post_controller.dart';
import 'package:final_year_project/models/user_post.dart';
import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/router/router.dart';

class UserProfileSection extends StatefulWidget {
  const UserProfileSection({
    required this.posts,
    this.user,
    Key? key,
  }) : super(key: key);
  final UserPosts posts;
  final UserModel? user;

  @override
  State<UserProfileSection> createState() => _UserProfileSectionState();
}

class _UserProfileSectionState extends State<UserProfileSection> {
  int followingCount = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final controller = context.read<PostController>();
      followingCount =
          await controller.getTotalFollowingCount(uid: widget.user!.uid);
      log('following count is $followingCount');
      setState(() {});
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          ListTile(
            leading: SizedBox(
              child: MyCircleAvatars(
                borderColor: Colors.black,
                img: widget.posts.profilePicture.toString(),
                raduis: 30,
              ),
            ),
            title: Text(widget.posts.name),
            subtitle: Text(followingCount.toString()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              children: [
                widget.posts.uid == FirebaseAuth.instance.currentUser!.uid
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          elevation: 10,
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
