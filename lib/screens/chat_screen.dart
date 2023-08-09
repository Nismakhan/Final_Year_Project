import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

import '../app/router/router.dart';
import '../common/helper.dart';
import '../models/chat_model.dart';
import '../utils/media_query.dart';
import 'message_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatQuery = FirebaseFirestore.instance
        .collection("chats")
        .where("userIds", arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .orderBy("dateModified", descending: true)
        .withConverter<ChatModel>(
          fromFirestore: (snapshot, options) =>
              ChatModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: screenWidth(context),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          const Text(
                            "Chats",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Expanded(
                        child: FirestoreListView<ChatModel>(
                          query: chatQuery,
                          shrinkWrap: true,
                          itemBuilder: (context, doc) {
                            final chat = doc.data();
                            final otherUser = chat.usersData.firstWhere(
                                (element) =>
                                    element.uid !=
                                    FirebaseAuth.instance.currentUser!.uid);

                            return Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRouter.messagesScreen,
                                      arguments:
                                          MessageScreenArgs(chatModel: chat));
                                },
                                child: ListTile(
                                  leading: otherUser.profilePic != null
                                      ? CircleAvatar(
                                          radius: 40,
                                          backgroundImage: NetworkImage(
                                              otherUser.profilePic!),
                                        )
                                      : CircleAvatar(
                                          radius: 40,
                                        ),
                                  title: Text(otherUser.name),
                                  subtitle: Text(
                                    chat.lastMessage.text,
                                  ),
                                  trailing: Text(Helper.getFormattedTime(
                                      chat.lastMessage.dateAdded.toDate())),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
