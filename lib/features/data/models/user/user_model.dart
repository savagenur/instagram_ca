import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_ca/features/domain/entities/user_entity.dart';

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
          uid: uid,
          userName: userName,
          name: name,
          bio: bio,
          website: website,
          email: email,
          profileUrl: profileUrl,
          followers: followers,
          following: following,
          totalFollowers: totalFollowers,
          totalFollowing: totalFollowing,
          totalPosts: totalPosts,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot["uid"],
      userName: snapshot["userName"],
      name: snapshot["name"],
      bio: snapshot["bio"],
      website: snapshot["website"],
      email: snapshot["email"],
      profileUrl: snapshot["profileUrl"],
      totalFollowers: snapshot["totalFollowers"],
      totalFollowing: snapshot["totalFollowing"],
      totalPosts: snapshot["totalPosts"],
      followers: List.from(snap.get("followers")),
      following: List.from(snap.get("following")),
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "userName": userName,
        "name": name,
        "bio": bio,
        "website": website,
        "email": email,
        "profileUrl": profileUrl,
        "followers": followers,
        "following": following,
        "totalFollowers": totalFollowers,
        "totalFollowing": totalFollowing,
        "totalPosts": totalPosts,
      };
}
