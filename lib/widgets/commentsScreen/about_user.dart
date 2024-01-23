import 'package:final_year_project/models/user_post.dart';
import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
import 'package:flutter/material.dart';

class AboutUser extends StatelessWidget {
  const AboutUser({
    required this.posts,
    Key? key,
  }) : super(key: key);
  final UserPosts posts;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              child: MyCircleAvatars(
                borderColor: Colors.blue.shade50,
                img: posts.profilePicture,
                raduis: 40,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                posts.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(posts.uniqueId!),
            ],
          ),
        ],
      ),
    );
  }
}
