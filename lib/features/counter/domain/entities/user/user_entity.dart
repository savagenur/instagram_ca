import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
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

  // will not going to store in DB

  final String? password;
  final String? otherUid;
  const UserEntity({
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
    this.password,
    this.otherUid,
  });

  @override
  List<Object?> get props => [
        uid,
        userName,
        name,
        bio,
        website,
        email,
        profileUrl,
        followers,
        following,
        totalFollowers,
        totalFollowing,
        totalPosts,
        password,
        otherUid,
      ];
}
