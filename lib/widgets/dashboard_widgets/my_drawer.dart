import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: SideBar(),
    );
  }
}

class SideBar extends StatefulWidget {
  const SideBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  Future signout() async {
    await FirebaseAuth.instance.signOut().then((value) {
      return Navigator.of(context).pushNamedAndRemoveUntil(
          AppRouter.userOrganization, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = context.read<AuthController>().appUser;
    return SizedBox(
      width: 300,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: AppColors.blueColor),
            accountName: Text(data!.name),
            accountEmail: Text(data.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey,
              child: ClipOval(
                child: data.profileUrl != null
                    ? GestureDetector(
                        onTap: () {
                          showProfileImageDialog(context, data.profileUrl!);
                        },
                        child: Image.network(
                          data.profileUrl.toString(),
                          fit: BoxFit.cover,
                          width: 90,
                          height: 90,
                        ),
                      )
                    : Image.asset(
                        'assets/images/user.png',
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Peoples'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Followers'),
            onTap: () {
              final uid = FirebaseAuth.instance.currentUser!.uid;
              Navigator.of(context)
                  .pushNamed(AppRouter.followersScreen, arguments: uid);
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('shared'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text('Exit'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              signout();
            },
          ),
        ],
      ),
    );
  }

  void showProfileImageDialog(BuildContext context, String view) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop(); // Close the dialog when tapped outside
          },
          child: Container(
            width: 600,
            height: 600,
            color: Colors.transparent, // Transparent background
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    view, // Replace with your image path
                    width: 500,
                    height: 500,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text('Check internet connection!');
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return CircularProgressIndicator();
                      } else {
                        return child;
                      }
                    },
                    //   fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
