import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/models/follow_model.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({required this.uid, super.key});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Following Users"),
      ),
      body: FirestoreListView<FollowModel>(
        query: FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("followed")
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
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                onPressed: () {
                  context.read<AuthController>().unFollow(uid: followModel.uid);
                },
                child: const Text("Unfollow"),
              ),
            ),
          );
        },
      ),
    );
  }
}
