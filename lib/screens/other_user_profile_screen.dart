import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/auth/models/user_model.dart';
import 'package:final_year_project/common/controller/post_controller.dart';
import 'package:final_year_project/models/user_post.dart';
import 'package:final_year_project/screens/profile_screen.dart';
import 'package:final_year_project/utils/const.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/dashboard_widgets/notices_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/profile_screen_widgets/user_profile_section.dart';

class OtherUserProfileScreen extends StatefulWidget {
  const OtherUserProfileScreen({required this.args, super.key});

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();

  final OtherUserProfileArgs args;
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  late UserModel user;
  late List<UserPosts>? userPosts;

  LoadingState _state = LoadingState.idle;

  LoadingState get state => _state;

  set state(LoadingState state) {
    setState(() {
      _state = state;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        state = LoadingState.processing;
        user = await context
            .read<AuthController>()
            .getUserById(uid: widget.args.uid);
        userPosts = await context
            .read<PostController>()
            .getCurrentUsersPosts(uid: widget.args.uid);
        state = LoadingState.loaded;
      } catch (e) {
        state = LoadingState.error;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        // leading: const Icon(
        //   Icons.arrow_back,
        //   size: 30,
        // ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: MoreVertOutlined(),
          ),
        ],
      ),
      body: Builder(builder: (context) {
        switch (state) {
          case LoadingState.idle:
            return const SizedBox();
          case LoadingState.processing:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case LoadingState.error:
            return const Center(
              child: Text("There was an error loading profile"),
            );
          case LoadingState.loaded:
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    width: screenWidth(context),
                    child: UserProfileSection(
                      user: user,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    height: 2,
                  ),
                  Expanded(
                    child: NoticesGrid(
                      posts: userPosts,
                    ),
                  ),
                ],
              ),
            );
        }
      }),
    );
  }
}

class OtherUserProfileArgs {
  String uid;
  OtherUserProfileArgs({required this.uid});
}

class PhotosVediosAndTaggedSection extends StatelessWidget {
  const PhotosVediosAndTaggedSection({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text),
      ),
    );
  }
}
