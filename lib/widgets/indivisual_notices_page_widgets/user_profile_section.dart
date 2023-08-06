import 'package:final_year_project/models/user_post.dart';
import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
import 'package:flutter/material.dart';

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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 10,
                  ),
                  onPressed: () {},
                  child: const Text("Message"),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 10,
                  ),
                  onPressed: () {},
                  child: const Text("Follow"),
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
