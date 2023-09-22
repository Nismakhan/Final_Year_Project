import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/models/user_post.dart';
import 'package:final_year_project/screens/comments.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("2 hours ago"),
                Icon(Icons.share),
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
              // "Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator.",
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
                Row(
                  children: const [
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
                    const Icon(
                      Icons.archive,
                      size: 20,
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
