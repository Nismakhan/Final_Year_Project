import 'package:final_year_project/app/router/router.dart';
import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/auth/models/user_model.dart';
import 'package:final_year_project/common/controller/post_controller.dart';
import 'package:final_year_project/utils/image_dailogue.dart';
import 'package:final_year_project/widgets/profile_screen_widgets/no_of_followers_post_and_following.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/explore.dart';
import '../../screens/message_screen.dart';

class UserProfileSection extends StatefulWidget {
  const UserProfileSection({
    required this.user,
    Key? key,
  }) : super(key: key);
  final UserModel user;

  @override
  State<UserProfileSection> createState() => _UserProfileSectionState();
}

class _UserProfileSectionState extends State<UserProfileSection> {
  int postsCount = 0;
  int followersCount = 0;
  int followingCount = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final controller = context.read<PostController>();
      postsCount = await controller.getTotalPostCount(uid: widget.user.uid);
      followersCount =
          await controller.getTotalFollowerCount(uid: widget.user.uid);
      followingCount =
          await controller.getTotalFollowingCount(uid: widget.user.uid);
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<AuthController>(builder: (context, provider, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.user.uid == provider.appUser!.uid
                  ? provider.isUploading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Stack(
                          children: [
                            provider.appUser!.profileUrl != null
                                ? GestureDetector(
                                    onTap: () {
                                      showProfileImageDialog(
                                          context,
                                          provider.appUser!.profileUrl
                                              .toString());
                                    },
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          provider.appUser!.profileUrl!),
                                    ),
                                  )
                                : const CircleAvatar(
                                    radius: 50,
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 163, 194),
                                    backgroundImage:
                                        AssetImage("assets/images/user.png"),
                                  ),
                            Positioned(
                              right: 0,
                              bottom: 00,
                              child: CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return imageDialogue(
                                            context,
                                            onSelect: (file) {
                                              provider.changeImage(image: file);
                                            },
                                          );
                                        });
                                  },
                                  icon: const Icon(Icons.camera),
                                ),
                              ),
                            ),
                          ],
                        )
                  : widget.user.profileUrl != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage(widget.user.profileUrl!),
                        )
                      : const CircleAvatar(
                          radius: 50,
                          backgroundColor: Color.fromARGB(255, 255, 163, 194),
                          backgroundImage: AssetImage("assets/images/user.png"),
                        ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.user.uniqueId.toString(),
                    style: const TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(255, 68, 68, 68),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  widget.user.uid != provider.appUser!.uid
                      ? Row(
                          children: [
                            Container(
                              width: 120,
                              height: 35,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 228, 211, 62),
                                    Colors.deepOrange,
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              child: FollowUnfollowButton(user: widget.user),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouter.messagesScreen,
                                  arguments: MessageScreenArgs(
                                      passedUser: widget.user),
                                );
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                // height: 30,

                                child: const Center(
                                  child: Icon(
                                    Icons.message,
                                    size: 17,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          );
        }),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NoOfFollowersPostAndFollowings(
              counting: followingCount.toString(),
              text: "Following",
              onpressed: () {
                Navigator.pushNamed(context, AppRouter.followingScreen,
                    arguments: widget.user.uid);
              },
            ),
            NoOfFollowersPostAndFollowings(
              counting: postsCount.toString(),
              text: "Posts",
            ),
            NoOfFollowersPostAndFollowings(
              counting: followersCount.toString(),
              text: "Followers",
              onpressed: () {
                Navigator.pushNamed(context, AppRouter.followersScreen,
                    arguments: widget.user.uid);
              },
            ),
          ],
        )
      ],
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
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return CircularProgressIndicator();
                      } else {
                        return child;
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Text('Failed to load an image');
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
