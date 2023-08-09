import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/router/router.dart';
import '../auth/models/user_model.dart';
import '../models/follow_model.dart';
import 'other_user_profile_screen.dart';

class Explore extends StatelessWidget {
  Explore({super.key});

  final query = FirebaseFirestore.instance
      .collection("users")
      .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .withConverter<UserModel>(
        fromFirestore: (snapShot, options) =>
            UserModel.fromJson(snapShot.data()!),
        toFirestore: (user, option) => user.toJson(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Exlpore people"),
      ),
      body: FirestoreListView<UserModel>(
        query: query,
        loadingBuilder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        itemBuilder: (context, snapshot) {
          final user = snapshot.data();
          // bool isFollow = false;
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRouter.otherUserprofileScreen,
                  arguments: OtherUserProfileArgs(uid: user.uid));
            },
            child: ListTile(
                leading: user.profileUrl != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(user.profileUrl!),
                        radius: 30,
                      )
                    : const CircleAvatar(
                        radius: 30,
                      ),
                title: Text(user.name),
                subtitle: Text(user.uniqueId.toString()),
                trailing: FollowUnfollowButton(user: user)

                // ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //         backgroundColor: Colors.grey),
                //     onPressed: () {},
                //     child: const Text(
                //       "Unfollow",
                //     ),
                //   ),
                ),
          );
        },
      ),
    );
  }
}

class FollowUnfollowButton extends StatefulWidget {
  const FollowUnfollowButton({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  State<FollowUnfollowButton> createState() => _FollowUnfollowButtonState();
}

class _FollowUnfollowButtonState extends State<FollowUnfollowButton> {
  bool isFollowed = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final result = await context
          .read<AuthController>()
          .isUserFollowed(uid: widget.user.uid);
      setState(() {
        isFollowed = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isFollowed
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            onPressed: () async {
              try {
                await context
                    .read<AuthController>()
                    .unFollow(uid: widget.user.uid);
                setState(() {
                  isFollowed = false;
                });
              } catch (e) {
                log(e.toString());
              }
            },
            child: const Text("Unfollow"),
          )
        : ElevatedButton(
            onPressed: () async {
              try {
                final followModel = FollowModel(
                    uid: widget.user.uid,
                    userName: widget.user.name,
                    dateAdded: Timestamp.now(),
                    profileUrl: widget.user.profileUrl);
                await context
                    .read<AuthController>()
                    .followUser(followModel: followModel);
                setState(() {
                  isFollowed = true;
                });
              } catch (e) {
                log(e.toString());
              }
            },
            child: const Text("Follow"),
          );
  }
}
