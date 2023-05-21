import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_ca/constants.dart';

import 'package:instagram_ca/features/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:instagram_ca/features/data/models/user/user_model.dart';
import 'package:instagram_ca/features/domain/entities/user_entity.dart';

// Learn All this document! It's about FirebaseAuth
class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  FirebaseRemoteDataSourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });
  @override
  Future<void> createUser(UserEntity userEntity) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    final uid = await getCurrentUid();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        uid: userEntity.uid,
        userName: userEntity.userName,
        name: userEntity.name,
        bio: userEntity.bio,
        website: userEntity.website,
        email: userEntity.email,
        profileUrl: userEntity.profileUrl,
        followers: userEntity.followers,
        following: userEntity.following,
        totalFollowers: userEntity.totalFollowers,
        totalFollowing: userEntity.totalFollowing,
        totalPosts: userEntity.totalPosts,
      ).toJson();

      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((error) {
      toast("Some error occur");
    });
  }

  @override
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    final userCollection = firebaseFirestore
        .collection(FirebaseConst.users)
        .where("uid", isEqualTo: uid)
        .limit(1);
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<UserEntity>> getUsers(UserEntity userEntity) {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<void> signInUser(UserEntity userEntity) async {
    try {
      if (userEntity.email!.isNotEmpty || userEntity.password!.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: userEntity.email!, password: userEntity.password!);
      } else {
        print("Fields can't be empty");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        toast("User not found!");
      }
      if (e.code == "wrong-password") {
        toast("Invalid email or password!");
      }
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> signUpUser(UserEntity userEntity) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: userEntity.email!, password: userEntity.password!)
          .then((value) async {
        if (value.user?.uid != null) {
          await createUser(userEntity);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        toast("Email is already taken!");
      } else {
        toast("Something went wrong!");
      }
    }
  }

  @override
  Future<void> updateUser(UserEntity userEntity) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    Map<String, dynamic> userInformation = Map();
    if (userEntity.userName != '' && userEntity.userName != null)
      userInformation['userName'] = userEntity.userName;
    if (userEntity.name != '' && userEntity.name != null)
      userInformation['name'] = userEntity.name;
    if (userEntity.bio != '' && userEntity.bio != null)
      userInformation['bio'] = userEntity.bio;
    if (userEntity.website != '' && userEntity.website != null)
      userInformation['website'] = userEntity.website;
    if (userEntity.email != '' && userEntity.email != null)
      userInformation['email'] = userEntity.email;
    if (userEntity.profileUrl != '' && userEntity.profileUrl != null)
      userInformation['profileUrl'] = userEntity.profileUrl;
    if (userEntity.followers != '' && userEntity.followers != null)
      userInformation['followers'] = userEntity.followers;
    if (userEntity.totalFollowers != '' && userEntity.totalFollowers != null)
      userInformation['totalFollowers'] = userEntity.totalFollowers;
    if (userEntity.totalFollowing != '' && userEntity.totalFollowing != null)
      userInformation['totalFollowing'] = userEntity.totalFollowing;
    if (userEntity.totalPosts != '' && userEntity.totalPosts != null)
      userInformation['totalPosts'] = userEntity.totalPosts;
    userCollection.doc(userEntity.uid).update(userInformation);
  }
}
