import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_ca/features/counter/domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  final String? uid;
  final String? userName;
  final String? name;
  final String? bio;
  final String? website;
  final String? email;
  final String? profileUrl;
  final List? followers;
  final List? following;
  final num? totalFollowers;
  final num? totalFollowing;
  final num? totalPosts;
  UserModel({
    this.uid,
    this.userName,
    this.name,
    this.bio,
    this.website,
    this.email,
    this.profileUrl,
    this.followers,
    this.following,
    this.totalFollowers,
    this.totalFollowing,
    this.totalPosts,
  }) : super(
          bio: bio,
          email: email,
          followers: followers,
          following: following,
          name: name,
          profileUrl: profileUrl,
          totalFollowers: totalFollowers,
          totalFollowing: totalFollowing,
          uid: uid,
          userName: userName,
          website: website,
          totalPosts: totalPosts,
        );
  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      email: snapshot["email"],
      bio: snapshot["bio"],
      followers: List.from(snap.get("followers")),
      following: List.from(snap.get("following")),
      name: snapshot["name"],
      profileUrl: snapshot["profileUrl"],
      totalFollowers: snapshot["totalFollowers"],
      totalFollowing: snapshot["totalFollowing"],
      uid: snapshot["uid"],
      userName: snapshot["userName"],
      website: snapshot["website"],
      totalPosts: snapshot["totalPosts"],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "bio": bio,
        "followers": followers,
        "following": following,
        "name": name,
        "profileUrl": profileUrl,
        "totalFollowers": totalFollowers,
        "totalFollowing": totalFollowing,
        "userName": userName,
        "website": website,
        "totalPosts": totalPosts
      };
}
