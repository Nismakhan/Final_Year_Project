import 'dart:developer';
import 'package:final_year_project/common/helper.dart';
import 'package:final_year_project/common/repo/post_repo.dart';
import 'package:final_year_project/models/comment_model.dart';
import 'package:final_year_project/models/like_model.dart';
import 'package:final_year_project/models/user_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/const.dart';

class PostController with ChangeNotifier {
  final _repo = PostRepo();
  bool isloading = false;
  LoadingState state = LoadingState.idle;
  List<UserPosts>? currentUserPosts = List.empty(growable: true);

  Future<void> uploadPost(BuildContext context,
      {required UserPosts post, XFile? pickedImage}) async {
    try {
      isloading = true;
      notifyListeners();
      if (pickedImage != null) {
        final url = await Helper.uploadImage(
            id: post.postId,
            file: pickedImage,
            ref: "posts/${post.postId}/${pickedImage.name}");
        post.userPostsAsset = url;
        log("URL $url");
      }
      await _repo.uploadPost(post: post);
      isloading = false;
      currentUserPosts!.add(post);
      notifyListeners();
    } catch (e) {
      isloading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<List<UserPosts>?> getCurrentUsersPosts({required String uid}) async {
    try {
      if (uid == FirebaseAuth.instance.currentUser!.uid) {
        state = LoadingState.processing;
        currentUserPosts = await _repo.getCurrentUserPosts(uid: uid);
        state = LoadingState.loaded;
        notifyListeners();
        log(currentUserPosts.toString());
        return currentUserPosts;
      } else {
        return _repo.getCurrentUserPosts(uid: uid);
      }
    } catch (e) {
      state = LoadingState.error;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> addComment({required CommentModel commentModel}) async {
    try {
      await _repo.addComment(commentModel: commentModel);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> deleteComment({required CommentModel commentModel}) async {
    try {
      await _repo.delete(commentModel: commentModel);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> addLike(
      {required UserPosts post, required LikeModel likeModel}) async {
    try {
      await _repo.addLike(post: post, likeModel: likeModel);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> unLike({required String postId, required String likeId}) async {
    try {
      await _repo.unLike(postId: postId, likeId: likeId);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<int> getLikesCount({required String postId}) async {
    try {
      return await _repo.getLikesCount(postId: postId);
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getCommentCount({required String postId}) async {
    try {
      return await _repo.getCommentCount(postId: postId);
    } catch (e) {
      rethrow;
    }
  }

  Future<LikeModel?> isPostLikeByMe({required String postId}) async {
    try {
      return await _repo.isPostLikeByMe(postId: postId);
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getTotalPostCount({required String uid}) async {
    try {
      
      return await _repo.getTotalPostCount(uid: uid);
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getTotalFollowerCount({required String uid}) async {
    try {
      return await _repo.getTotalFollowerCount(uid: uid);
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getTotalFollowingCount({required String uid}) async {
    try {
      isloading=true;
      notifyListeners();
      return await _repo.getTotalFollowingCount(uid: uid);
    } catch (e) {
      rethrow;
    }
  }

  
}
