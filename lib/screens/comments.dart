// import 'package:final_year_project/utils/media_query.dart';
// import 'package:final_year_project/widgets/commentsScreen/about_user.dart';
// import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
// import 'package:flutter/material.dart';

// class Comments extends StatelessWidget {
//   const Comments({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: screenWidth(context) < 500
//           ? AppBar(
//               elevation: 0,
//               backgroundColor: Colors.transparent,
//               foregroundColor: Colors.black,
//             )
//           : null,
//       body: Center(
//         child: SizedBox(
//           width: screenWidth(context) < 500 ? screenWidth(context) : 700,
//           child: Column(
//             children: [
//               Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.green,
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(15),
//                     bottomRight: Radius.circular(15),
//                   ),
//                   image: DecorationImage(
//                     image: NetworkImage(
//                         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFRmWtO1zrO6tt35ewAJOE9NpAb8yiwhbrBWyxjVQCZw&s"),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//                 width: screenWidth(context),
//                 height: screenHeight(context) / 3,
//               ),
//               const AboutUser(),
//               const SizedBox(
//                 width: 350,
//                 child: Text("Desction in full detail"),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       leading: const MyCircleAvatars(
//                           borderColor: Colors.black, img: ""),
//                       title: const Text("Name"),
//                       subtitle: const Text("Comments"),
//                       trailing: Column(
//                         children: const [
//                           Text("2 hour ago"),
//                           Icon(Icons.delete),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       width: screenWidth(context) < 500
//                           ? screenWidth(context) * 0.73
//                           : 600,
//                       child: TextFormField(
//                         decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             label: Text("Write Something...")),
//                       ),
//                     ),
//                     const Icon(Icons.send),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
import 'package:final_year_project/models/user_post.dart';
import 'package:final_year_project/utils/colors.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/commentsScreen/about_user.dart';
import 'package:final_year_project/widgets/commentsScreen/comments_list_view.dart';
import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  const Comments({required this.post, super.key});

  final UserPosts post;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blueColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const AboutUser(),
              const SizedBox(
                height: 10,
              ),
              if (post.about != null)
                SizedBox(
                  width: screenWidth(context) * 0.8,
                  child: Text(
                    post.about!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CommentsListView(
                post: post,
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentArgs {
  UserPosts post;
  CommentArgs({required this.post});
}
