import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/auth/controller/auth_controller.dart';
import 'package:final_year_project/common/controller/post_controller.dart';
import 'package:final_year_project/models/user_post.dart';
import 'package:final_year_project/utils/image_dailogue.dart';
import 'package:final_year_project/utils/media_query.dart';
import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../utils/colors.dart';

class UploadingPostWidget extends StatefulWidget {
  const UploadingPostWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<UploadingPostWidget> createState() => _UploadingPostWidgetState();
}

class _UploadingPostWidgetState extends State<UploadingPostWidget> {
  final _formKey = GlobalKey<FormState>();

  final _postText = TextEditingController();

  XFile? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            width: screenWidth(context) * 0.89,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    title: TextFormField(
                      style: const TextStyle(color: AppColors.blueColor),
                      controller: _postText,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty && _pickedImage == null) {
                          return "Either enter post text or upload image";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          label: Text("Write Something...")),
                    ),
                    trailing: const Icon(
                      Icons.edit,
                      color: AppColors.blueColor,
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  _pickedImage != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Row(
                            children: [
                              Builder(builder: (context) {
                                final file = File(_pickedImage!.path);
                                return Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Image.file(
                                      file,
                                      width: 80,
                                      height: 80,
                                    ),
                                    Positioned(
                                      right: -25,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _pickedImage = null;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          )),
                                    ),
                                  ],
                                );
                              })
                            ],
                          ),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.camera_alt,
                                color: AppColors.blueColor,
                                size: 25,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: ((context) {
                                      return imageDialogue(context,
                                          onSelect: (image) {
                                        setState(() {
                                          _pickedImage = image;
                                        });
                                      });
                                    }));
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Consumer<PostController>(
                            builder: (context, provider, _) {
                          log(provider.isloading.toString());
                          return provider.isloading
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.blueColor,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 100,
                                  height: 30,

                                  // gradient: LinearGradient(
                                  //   colors: [
                                  //     Color.fromARGB(255, 228, 211, 62),
                                  //     Colors.deepOrange,
                                  //   ],
                                  // begin: Alignment.centerLeft,
                                  // end: Alignment.centerRight,
                                  // ),
                                  // color: AppColors.blueColor,

                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: AppColors.blueColor),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          final currentUser = context
                                              .read<AuthController>()
                                              .appUser!;
                                          final postModel = UserPosts(
                                            uid: currentUser.uid,
                                            postId: const Uuid().v1(),
                                            name: currentUser.name,
                                            about: _postText.text,
                                            profilePicture:
                                                currentUser.profileUrl,
                                            dateAdded: Timestamp.now(),
                                            likesCount: 0,
                                            commentsCount: 0,
                                            shareCount: 0,
                                            lastLikes: [],
                                            uniqueId:
                                                currentUser.uniqueId.toString(),
                                          );
                                          await context
                                              .read<PostController>()
                                              .uploadPost(context,
                                                  post: postModel,
                                                  pickedImage: _pickedImage);
                                          _postText.clear();
                                          // WidgetsBinding.instance.focusManager
                                          //     .primaryFocus
                                          //     ?.unfocus();
                                          setState(() {
                                            _pickedImage = null;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content:
                                                      Text("Post Uploaded")));
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "There was an issue $e")));
                                        }
                                      }
                                    },
                                    child: const Text(
                                      "Share",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                        }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
