import 'dart:io';

import 'package:instagram_ca/features/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:instagram_ca/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_ca/features/domain/entities/post/post_entity.dart';
import 'package:instagram_ca/features/domain/entities/reply/reply_entity.dart';
import 'package:instagram_ca/features/domain/entities/user/user_entity.dart';
import 'package:instagram_ca/features/domain/repository/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;
  FirebaseRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<void> createUser(UserEntity userEntity) async =>
      remoteDataSource.createUser(userEntity);

  @override
  Future<String> getCurrentUid() async => remoteDataSource.getCurrentUid();

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) =>
      remoteDataSource.getSingleUser(uid);

  @override
  Stream<List<UserEntity>> getUsers(UserEntity userEntity) =>
      remoteDataSource.getUsers(userEntity);

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> signInUser(UserEntity userEntity) async =>
      remoteDataSource.signInUser(userEntity);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUpUser(UserEntity userEntity) async =>
      remoteDataSource.signUpUser(userEntity);

  @override
  Future<void> updateUser(UserEntity userEntity) async =>
      remoteDataSource.updateUser(userEntity);

  @override
  Future<String> uploadImageToStorage(
      File? file, bool isPost, String childName) async {
    return remoteDataSource.uploadImageToStorage(file, isPost, childName);
  }

  @override
  Future<void> createUserWithImage(
      UserEntity userEntity, String profileUrl) async {
    return remoteDataSource.createUserWithImage(userEntity, profileUrl);
  }

  @override
  Future<void> createPost(PostEntity postEntity) async =>
      remoteDataSource.createPost(postEntity);

  @override
  Future<void> deletePost(PostEntity postEntity) async =>
      remoteDataSource.deletePost(postEntity);

  @override
  Future<void> likePost(PostEntity postEntity) async =>
      remoteDataSource.likePost(postEntity);

  @override
  Stream<List<PostEntity>> readPost(PostEntity postEntity) =>
      remoteDataSource.readPost(postEntity);

  @override
  Stream<List<PostEntity>> readSinglePost(String postId) =>
      remoteDataSource.readSinglePost(postId);

  @override
  Future<void> updatePost(PostEntity postEntity) async =>
      remoteDataSource.updatePost(postEntity);

  @override
  Future<void> createComment(CommentEntity commentEntity) async =>
      remoteDataSource.createComment(commentEntity);

  @override
  Future<void> deleteComment(CommentEntity commentEntity) async =>
      remoteDataSource.deleteComment(commentEntity);

  @override
  Future<void> likeComment(CommentEntity commentEntity) async =>
      remoteDataSource.likeComment(commentEntity);

  @override
  Stream<List<CommentEntity>> readComments(String postId) =>
      remoteDataSource.readComments(postId);

  @override
  Future<void> updateComment(CommentEntity commentEntity) async =>
      remoteDataSource.updateComment(commentEntity);

  @override
  Future<void> createReply(ReplyEntity replyEntity) 
async=>remoteDataSource.createReply(replyEntity);

  @override
  Future<void> deleteReply(ReplyEntity replyEntity) async=>remoteDataSource.deleteReply(replyEntity);

  @override
  Future<void> likeReply(ReplyEntity replyEntity) async=>remoteDataSource.likeReply(replyEntity);

  @override
  Stream<List<ReplyEntity>> readReplies(ReplyEntity replyEntity) =>remoteDataSource.readReplies(replyEntity);

  @override
  Future<void> updateReply(ReplyEntity replyEntity) async=>remoteDataSource.updateReply(replyEntity);
      
      
}
