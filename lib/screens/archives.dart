import 'package:final_year_project/utils/media_query.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArchivedPostsScreen extends StatefulWidget {
  const ArchivedPostsScreen({Key? key}) : super(key: key);

  @override
  State<ArchivedPostsScreen> createState() => _ArchivedPostsScreenState();
}

class _ArchivedPostsScreenState extends State<ArchivedPostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archived Posts'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where('archived', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final archivedPosts = snapshot.data?.docs;

          if (archivedPosts!.isEmpty) {
            return const Center(child: Text('No archived posts found.'));
          }

          return ListView.builder(
            itemCount: archivedPosts.length,
            itemBuilder: (context, index) {
              final post = archivedPosts[index];

              // Access the 'about' and 'postAsset' fields using data()
              final about = post["about"];
              final postAsset = post["userPostsAsset"];

              return Column(
                children: [
                  Text(about),
                  postAsset != null
                      ? Container(
                          height: 250,
                          width: screenWidth(context) < 500
                              ? screenWidth(context)
                              : 450,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green,
                            image: DecorationImage(
                              image: NetworkImage(postAsset.toString()),
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : Image.asset("assets/images/image not found.png"),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
