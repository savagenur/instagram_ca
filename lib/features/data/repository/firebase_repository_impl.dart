import 'dart:io';

import 'package:instagram_ca/features/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:instagram_ca/features/domain/entities/user_entity.dart';
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
  Future<void> createUserWithImage(UserEntity userEntity, String profileUrl) async {
    return remoteDataSource.createUserWithImage(userEntity, profileUrl);
  }
}
