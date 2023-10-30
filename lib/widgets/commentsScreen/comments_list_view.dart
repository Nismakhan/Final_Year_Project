import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/common/controller/post_controller.dart';
import 'package:final_year_project/models/comment_model.dart';
import 'package:final_year_project/models/user_post.dart';
import 'package:final_year_project/screens/other_user_profile_screen.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../auth/models/user_model.dart';

class CommentsListView extends StatefulWidget {
  const CommentsListView({
    this.isBottomSheet,
    required this.post,
    Key? key,
  }) : super(key: key);

  final UserPosts post;
  final bool? isBottomSheet;

  @override
  State<CommentsListView> createState() => _CommentsListViewState();
}

class _CommentsListViewState extends State<CommentsListView> {
  final _formKey = GlobalKey<FormState>();

  final _commentCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height:
                  widget.isBottomSheet != null && widget.isBottomSheet == true
                      ? screenHeight(context) / 2
                      : screenHeight(context) * 0.6,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("posts")
                    .doc(widget.post.postId)
                    .collection("comments")
                    .orderBy("dateAdded", descending: true)
                    .snapshots(),
                builder: (context, commentsSnapshot) {
                  if (commentsSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (commentsSnapshot.hasError) {
                    return Text('Error: ${commentsSnapshot.error}');
                  } else {
                    final commentsDocs = commentsSnapshot.data!.docs;
                    final comments = commentsDocs
                        .map((e) => CommentModel.fromJson(
                            e.data() as Map<String, dynamic>))
                        .toList();

                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .snapshots(),
                      builder: (context, usersSnapshot) {
                        if (usersSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (usersSnapshot.hasError) {
                          return Text('Error: ${usersSnapshot.error}');
                        } else {
                          final userDocs = usersSnapshot.data!.docs;

                          return buildCommentList(comments, userDocs);
                        }
                      },
                    );
                  }
                },
              )),
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _commentCon,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Comment is required";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text('Write a comment...'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final currentUser =
                          context.read<AuthController>().appUser;
                      final comment = CommentModel(
                        commentId: const Uuid().v1(),
                        text: _commentCon.text,
                        uid: currentUser!.uid,
                        profileUrl: currentUser.profileUrl,
                        userName: currentUser.name,
                        dateAdded: Timestamp.now(),
                        postId: widget.post.postId,
                      );
                      context
                          .read<PostController>()
                          .addComment(commentModel: comment);
                      _commentCon.clear();
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blue,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

Widget  buildCommentList(
    List<CommentModel> comments, List<DocumentSnapshot> userDocs) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: comments.length,
    itemBuilder: ((context, index) {
      final comment = comments[index];
      final userData = userDocs
          .map((document) =>
              UserModel.fromJson(document.data() as Map<String, dynamic>))
          .firstWhere((user) => user.uid == comment.uid);

      return CommentWidget(
        comment: comment,
        user: userData,
      );
    }),
  );
}

class CommentWidget extends StatefulWidget {
  const CommentWidget({
    required this.comment,
    this.user,
    Key? key,
  }) : super(key: key);

  final CommentModel comment;
  final UserModel? user;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.comment.uid == FirebaseAuth.instance.currentUser!.uid
            ? IconButton(
                onPressed: () {
                  context
                      .read<PostController>()
                      .deleteComment(commentModel: widget.comment);
                },
                icon: const Icon(Icons.delete))
            : const SizedBox(),
        ListTile(
          leading: GestureDetector(
            onTap: () {
              if (widget.comment.uid ==
                  FirebaseAuth.instance.currentUser!.uid) {
                Navigator.of(context).pushNamed(
                  AppRouter.profileScreen,
                );
              } else {
                Navigator.of(context).pushNamed(
                  AppRouter.otherUserprofileScreen,
                  arguments: OtherUserProfileArgs(uid: widget.comment.uid),
                );
              }
            },
            child: MyCircleAvatars(
              borderColor: Colors.black,
              img: widget.comment.profileUrl.toString(),
            ),
          ),
          title: Text(
            widget.comment.userName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            widget.comment.text,
            style: const TextStyle(fontSize: 17, color: Colors.grey),
          ),
          trailing: Text(timeago.format(widget.comment.dateAdded.toDate())),
        ),
      ],
    );
  }
}
