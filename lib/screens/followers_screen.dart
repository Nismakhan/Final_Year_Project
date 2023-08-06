import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/models/follow_model.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({required this.uid, super.key});

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Followers"),
      ),
      body: FirestoreListView<FollowModel>(
        query: FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("followers")
            .withConverter<FollowModel>(
                fromFirestore: (snap, options) =>
                    FollowModel.fromJson(snap.data()!),
                toFirestore: (snap, options) => snap.toJson()),
        itemBuilder: (context, snap) {
          final followModel = snap.data();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: followModel.profileUrl != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(followModel.profileUrl!),
                      radius: 30,
                    )
                  : const CircleAvatar(
                      radius: 30,
                    ),
              title: Text(followModel.userName),
              trailing: FollowersTileTrailing(
                followModel: followModel,
              ),
            ),
          );
        },
      ),
    );
  }
}

class FollowersTileTrailing extends StatefulWidget {
  const FollowersTileTrailing({
    required this.followModel,
    Key? key,
  }) : super(key: key);
  final FollowModel followModel;
  @override
  State<FollowersTileTrailing> createState() => _FollowersTileTrailingState();
}

class _FollowersTileTrailingState extends State<FollowersTileTrailing> {
  bool isLoading = true;
  bool isFollowed = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      isFollowed = await context
          .read<AuthController>()
          .isUserFollowed(uid: widget.followModel.uid);
      isLoading = false;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : Wrap(
            children: [
              !isFollowed
                  ? ElevatedButton(
                      onPressed: () async {
                        context
                            .read<AuthController>()
                            .followUser(followModel: widget.followModel);
                        setState(() {
                          isFollowed = true;
                        });
                      },
                      child: const Text("Follow Back"),
                    )
                  : const SizedBox(),
              const SizedBox(
                width: 5,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  context
                      .read<AuthController>()
                      .removeFollower(uid: widget.followModel.uid);
                },
                child: const Text("Remove"),
              ),
            ],
          );
  }
}
