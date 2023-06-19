import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:instagram_ca/constants.dart';
import 'package:instagram_ca/features/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:instagram_ca/features/data/models/post/post_model.dart';
import 'package:instagram_ca/features/data/models/user/user_model.dart';
import 'package:instagram_ca/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_ca/features/domain/entities/post/post_entity.dart';
import 'package:instagram_ca/features/domain/entities/user/user_entity.dart';
import 'package:uuid/uuid.dart';

// Learn All this document! It's about FirebaseAuth
class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;
  FirebaseRemoteDataSourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
    required this.firebaseStorage,
  });

  @override
  Future<void> createUser(UserEntity userEntity) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    final uid = await getCurrentUid();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        uid: uid,
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
          .then((currentUser) async {
        if (currentUser.user?.uid != null) {
          if (userEntity.imageFile != null) {
            uploadImageToStorage(userEntity.imageFile, false, "profileImages")
                .then((profileUrl) {
              createUserWithImage(userEntity, profileUrl);
            });
          } else {
            createUserWithImage(userEntity, "");
          }
        }
      });
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        toast("email is already taken");
      } else {
        toast("something went wrong");
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

  @override
  Future<String> uploadImageToStorage(
      File? file, bool isPost, String childName) async {
    Reference ref = firebaseStorage
        .ref()
        .child(childName)
        .child(firebaseAuth.currentUser!.uid);

    if (isPost) {
      String id = Uuid().v1();
      ref = ref.child(id);
    }

    final uploadTask = ref.putFile(file!);

    final imageUrl =
        (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return await imageUrl;
  }

  @override
  Future<void> createUserWithImage(
      UserEntity userEntity, String profileUrl) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    final uid = await getCurrentUid();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        uid: uid,
        userName: userEntity.userName,
        name: userEntity.name,
        bio: userEntity.bio,
        website: userEntity.website,
        email: userEntity.email,
        profileUrl: profileUrl,
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
  Future<void> createPost(PostEntity postEntity) async {
    final postCollection = firebaseFirestore.collection(FirebaseConst.posts);
    final newPost = PostModel(
      userProfileUrl: postEntity.userProfileUrl,
      userName: postEntity.userName,
      totalLikes: 0,
      totalComments: 0,
      postImageUrl: postEntity.postImageUrl,
      postId: postEntity.postId,
      likes: [],
      description: postEntity.description,
      creatorUid: postEntity.creatorUid,
      createAt: postEntity.createAt,
    ).toJson();
    try {
      final postDocRef = await postCollection.doc(postEntity.postId).get();
      if (!postDocRef.exists) {
        postCollection.doc(postEntity.postId).set(newPost);
      } else {
        postCollection.doc(postEntity.postId).update(newPost);
      }
    } catch (e) {
      print("Some error occurred: $e");
    }
  }

  @override
  Future<void> deletePost(PostEntity postEntity) async {
    final postCollection = firebaseFirestore.collection(FirebaseConst.posts);
    try {
      postCollection.doc(postEntity.postId).delete();
    } catch (e) {
      print("Some error occurred: $e");
    }
  }

  @override
  Future<void> likePost(PostEntity postEntity) async {
    final postCollection = firebaseFirestore.collection(FirebaseConst.posts);
    final currentUid = await getCurrentUid();
    final postRef = await postCollection.doc(postEntity.postId).get();
    if (postRef.exists) {
      List likes = postRef.get("likes");
      final totalLikes = postRef.get("totalLikes");
      if (likes.contains(currentUid)) {
        postCollection.doc(postEntity.postId).update({
          "likes": FieldValue.arrayRemove([currentUid]),
          "totalLikes": totalLikes - 1
        });
      } else {
        postCollection.doc(postEntity.postId).update({
          "likes": FieldValue.arrayUnion([currentUid]),
          "totalLikes": totalLikes + 1
        });
      }
    }
  }

  @override
  Stream<List<PostEntity>> readPost(PostEntity postEntity) {
    final postCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .orderBy("createAt", descending: true);
    return postCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => PostModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> updatePost(PostEntity postEntity) async {
    final postCollection = firebaseFirestore.collection(FirebaseConst.posts);
    Map<String, dynamic> postInfo = Map();

    if (postEntity.description != "" && postEntity.description != null)
      postInfo["description"] = postEntity.description;
    if (postEntity.postImageUrl != "" && postEntity.postImageUrl != null)
      postInfo["postImageUrl"] = postEntity.postImageUrl;
    postCollection.doc(postEntity.postId).update(postInfo);
  }

  @override
  Future<void> createComment(CommentEntity commentEntity) {
    // TODO: implement createComment
    throw UnimplementedError();
  }

  @override
  Future<void> deleteComment(CommentEntity commentEntity) {
    // TODO: implement deleteComment
    throw UnimplementedError();
  }

  @override
  Future<void> likeComment(CommentEntity commentEntity) {
    // TODO: implement likeComment
    throw UnimplementedError();
  }

  @override
  Stream<List<PostEntity>> readComment(String postId) {
    // TODO: implement readComment
    throw UnimplementedError();
  }

  @override
  Future<void> updateComment(CommentEntity commentEntity) {
    // TODO: implement updateComment
    throw UnimplementedError();
  }
}
