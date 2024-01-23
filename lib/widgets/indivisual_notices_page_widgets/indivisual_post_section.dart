import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/models/user_post.dart';
import 'package:final_year_project/screens/comments.dart';
import 'package:final_year_project/utils/colors.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

class IndividualPostSection extends StatefulWidget {
  const IndividualPostSection({
    required this.post,
    Key? key,
  }) : super(key: key);

  final UserPosts post;

  @override
  State<IndividualPostSection> createState() => _IndividualPostSectionState();
}

class _IndividualPostSectionState extends State<IndividualPostSection> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isArchived = false;
  Future<void> _archivePost() async {
    try {
      await _firestore.collection('posts').doc(widget.post.postId).update({
        'archived': true, // Add 'archived' field in your Firestore document
      });
      setState(() {
        isArchived = true; // Set the local state to archived
      });
      Navigator.of(context).pop(); // Close the dialog
    } catch (e) {
      print('Error archiving post: $e');
    }
  }

  Future<void> _unarchivePost() async {
    try {
      await _firestore.collection('posts').doc(widget.post.postId).update({
        'archived': false,
      });
      setState(() {
        isArchived = false; // Set the local state to unarchived
      });
      Navigator.of(context).pop(); // Close the dialog
    } catch (e) {
      print('Error unarchiving post: $e');
    }
  }

  Future<void> shareText(String text) async {
    await Share.share(text, subject: 'Share Text');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(timeago.format(widget.post.dateAdded.toDate())),
                GestureDetector(
                    onTap: () async {
                      widget.post.userPostsAsset != null
                          ? await shareText(
                              widget.post.userPostsAsset.toString(),
                            )
                          : showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog.adaptive(
                                  content: Text('Image Not Found'),
                                );
                              },
                            );
                    },
                    child: const Icon(
                      Icons.share,
                      color: AppColors.blueColor,
                      size: 25,
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          widget.post.userPostsAsset != null
              ? Container(
                  height: 250,
                  width:
                      screenWidth(context) < 500 ? screenWidth(context) : 450,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green,
                    image: DecorationImage(
                      image:
                          NetworkImage(widget.post.userPostsAsset.toString()),
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              : Image.asset("assets/images/image not found.png"),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: screenWidth(context) < 500 ? 250 : screenWidth(context),
            child: Text(
              widget.post.about.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.thumb_up,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Like",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: isArchived ? _unarchivePost : _archivePost,
                      child: const Icon(
                        Icons.archive,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRouter.comments,
                            arguments: CommentArgs(post: widget.post));
                      },
                      child: const Icon(
                        Icons.comment_bank_outlined,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 5,
          )
        ],
      ),
    );
  }
}
