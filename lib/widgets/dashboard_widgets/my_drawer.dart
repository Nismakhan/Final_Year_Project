// import 'dart:ui';

// import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
// import 'package:final_year_project/widgets/dashboard_widgets/row_for_archives_posts_contact_etc.dart';
// import 'package:flutter/material.dart';

// class MyDrawer extends StatelessWidget {
//   const MyDrawer({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Drawer(
//         backgroundColor: const Color.fromARGB(255, 29, 29, 29),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(
//               height: 30,
//             ),
//             Stack(
//               clipBehavior: Clip.none,
//               children: const [
//                 MyCircleAvatars(
//                   borderColor: Colors.white,
//                   img:
//                       "https://images.unsplash.com/photo-1574169208507-84376144848b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8aW1hZ2VzJTIwb2YlMjBhdmF0YXJzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
//                   raduis: 60,
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   child: Icon(
//                     Icons.camera_alt,
//                     color: Colors.white,
//                     size: 40,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Text(
//               "Nisma Khan",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//               ),
//             ),
//             const Divider(
//               thickness: 2,
//               color: Colors.white,
//             ),
//             Column(
//               children: const [
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: RowForArchivesPostsContactEtc(
//                     icon: Icons.archive,
//                     text: "Archives",
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: RowForArchivesPostsContactEtc(
//                     icon: Icons.image,
//                     text: "Images",
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: RowForArchivesPostsContactEtc(
//                     icon: Icons.video_camera_back,
//                     text: "Vedios",
//                   ),
//                 ),
//                 Divider(
//                   thickness: 2,
//                   color: Colors.white,
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: SideBar(),
    );
  }
}

class SideBar extends StatelessWidget {
  const SideBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ListView(
        // Remove padding
        // padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 174, 243, 175)),
            accountName: const Text('Oflutter.com'),
            accountEmail: const Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Friends'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Request'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Policies'),
            onTap: () => null,
          ),
          const Divider(),
          ListTile(
            title: const Text('Exit'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
