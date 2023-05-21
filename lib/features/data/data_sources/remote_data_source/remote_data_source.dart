import 'package:instagram_ca/features/domain/entities/user_entity.dart';

abstract class FirebaseRemoteDataSource {
  // Credential
  Future<void> signInUser(UserEntity userEntity);
  Future<void> signUpUser(UserEntity userEntity);
  Future<bool> isSignIn();
  Future<void> signOut();

  // User
  Stream<List<UserEntity>> getUsers(UserEntity userEntity);
  Stream<List<UserEntity>> getSingleUser(String uid);
  Future<String> getCurrentUid();
  Future<void> createUser(UserEntity userEntity);
  Future<void> updateUser(UserEntity userEntity);
}
