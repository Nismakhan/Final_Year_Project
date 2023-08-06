import 'package:final_year_project/models/user_post.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:flutter/material.dart';

class NoticesGrid extends StatelessWidget {
  const NoticesGrid({
    required this.posts,
    Key? key,
  }) : super(key: key);
  final List<UserPosts>? posts;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: Colors.black,
      elevation: 6,
      color: const Color.fromARGB(255, 174, 243, 175),
      child: LayoutBuilder(
        builder: (context, constraint) {
          return SizedBox(
            height: screenHeight(context) * 0.44,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: GridView.builder(
                  // itemCount: posts.postId.length <= 4 ? posts.postId.length : 4,
                  itemCount: posts!.length <= 4 ? posts!.length : 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 6.6,
                      color: Colors.white,
                      child: Center(
                        child: Text(posts![index].about.toString()),
                      ),
                    );
                  }),
            ),
          );
        },
      ),
    );
  }
}
