import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/models/comment_model.dart';
import 'package:final_year_project/models/like_model.dart';
import 'package:final_year_project/models/user_post.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostRepo {
  final _firestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> uploadPost({required UserPosts post}) async {
    try {
      await _firestore.collection("posts").doc(post.postId).set(post.toJson());
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  Future<List<UserPosts>> getCurrentUserPosts({required String uid}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("posts")
          .where("uid", isEqualTo: uid)
          .get();
      List<UserPosts> posts =
          querySnapshot.docs.map((e) => UserPosts.fromJson(e.data())).toList();
      return posts;
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> addComment({required CommentModel commentModel}) async {
    try {
      await _firestore
          .collection("posts")
          .doc(commentModel.postId)
          .collection("comments")
          .doc(commentModel.commentId)
          .set(commentModel.toJson());

      await _firestore.collection("posts").doc(commentModel.postId).update({
        "commentsCount": FieldValue.increment(1),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addLike(
      {required UserPosts post, required LikeModel likeModel}) async {
    try {
      final listofLikes = post.lastLikes;

      final isLikeBefore =
          listofLikes.any((element) => element["uid"] == likeModel.uid);

      if (!isLikeBefore) {
        if (listofLikes.length > 2) {
          listofLikes.removeAt(0);
        }
        listofLikes.add({
          "uid": likeModel.uid,
          "name": likeModel.userName,
          "profileUrl": likeModel.profileUrl,
        });
      }

      await _firestore
          .collection("posts")
          .doc(likeModel.postId)
          .collection("likes")
          .doc(likeModel.likeId)
          .set(likeModel.toJson());

      await _firestore.collection("posts").doc(likeModel.postId).update({
        "likesCount": FieldValue.increment(1),
        "lastLikes": listofLikes,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> unLike({required String postId, required String likeId}) async {
    try {
      await _firestore
          .collection("posts")
          .doc(postId)
          .collection("likes")
          .doc(likeId)
          .delete();

      await _firestore.collection("posts").doc(postId).update({
        "likesCount": FieldValue.increment(-1),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete({required CommentModel commentModel}) async {
    try {
      await _firestore
          .collection("posts")
          .doc(commentModel.postId)
          .collection("comments")
          .doc(commentModel.commentId)
          .delete();
      await _firestore.collection("posts").doc(commentModel.postId).update({
        "commentsCount": FieldValue.increment(-1),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getLikesCount({required String postId}) async {
    try {
      return (await _firestore
              .collection("posts")
              .doc(postId)
              .collection("likes")
              .count()
              .get())
          .count;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getCommentCount({required String postId}) async {
    try {
      return (await _firestore
              .collection("posts")
              .doc(postId)
              .collection("comments")
              .count()
              .get())
          .count;
    } catch (e) {
      rethrow;
    }
  }

  Future<LikeModel?> isPostLikeByMe({required String postId}) async {
    try {
      final docs = (await _firestore
              .collection("posts")
              .doc(postId)
              .collection("likes")
              .where("uid", isEqualTo: _firebaseAuth.currentUser!.uid)
              .get())
          .docs;

      if (docs.isNotEmpty) {
        return LikeModel.fromJson(docs.first.data());
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getTotalPostCount({required String uid}) async {
    try {
      return (await _firestore
              .collection("posts")
              .where("uid", isEqualTo: uid)
              .count()
              .get())
          .count;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getTotalFollowerCount({required String uid}) async {
    try {
      return (await _firestore
              .collection("users")
              .doc(uid)
              .collection("followers")
              .count()
              .get())
          .count;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getTotalFollowingCount({required String uid}) async {
    try {
      return (await _firestore
              .collection("users")
              .doc(uid)
              .collection("followed")
              .count()
              .get())
          .count;
    } catch (e) {
      rethrow;
    }
  }
}
