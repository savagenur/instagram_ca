import 'dart:io';

import 'package:instagram_ca/features/domain/entities/user/user_entity.dart';

import '../../../domain/entities/post/post_entity.dart';

abstract class FirebaseRemoteDataSource {
  // Credential features
  Future<void> signInUser(UserEntity userEntity);
  Future<void> signUpUser(UserEntity userEntity);
  Future<bool> isSignIn();
  Future<void> signOut();

  // User features
  Stream<List<UserEntity>> getUsers(UserEntity userEntity);
  Stream<List<UserEntity>> getSingleUser(String uid);
  Future<String> getCurrentUid();
  Future<void> createUser(UserEntity userEntity);
  Future<void> createUserWithImage(UserEntity userEntity, String profileUrl);
  Future<void> updateUser(UserEntity userEntity);

  // Cloud Storage features
  Future<String> uploadImageToStorage(
      File? file, bool isPost, String childName);

  // Post features
  Future<void> createPost(PostEntity postEntity);
  Stream<List<PostEntity>> readPost(PostEntity postEntity);
  Future<void> updatePost(PostEntity postEntity);
  Future<void> deletePost(PostEntity postEntity);
  Future<void> likePost(PostEntity postEntity);
}
