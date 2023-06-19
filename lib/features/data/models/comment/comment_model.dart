import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_ca/features/domain/entities/comment/comment_entity.dart';

class CommentModel extends CommentEntity {
  final String? commentId;
  final String? postId;
  final String? creatorUid;
  final String? description;
  final String? userName;
  final String? userProfileUrl;
  final Timestamp? createdAt;
  final List<String>? likes;
  final num? totalReplies;

  CommentModel({
    this.commentId,
    this.postId,
    this.creatorUid,
    this.description,
    this.userName,
    this.userProfileUrl,
    this.createdAt,
    this.likes,
    this.totalReplies,
  }) : super(
          commentId: commentId,
          postId: postId,
          creatorUid: creatorUid,
          description: description,
          userName: userName,
          userProfileUrl: userProfileUrl,
          createdAt: createdAt,
          likes: likes,
          totalReplies: totalReplies,
        );

  factory CommentModel.fromSnapshot(DocumentSnapshot snap) {
    final snapshot = snap.data() as Map<String, dynamic>;
    return CommentModel(
      commentId: snapshot["commentId"],
      postId: snapshot["postId"],
      creatorUid: snapshot["creatorUid"],
      description: snapshot["description"],
      userName: snapshot["userName"],
      userProfileUrl: snapshot["userProfileUrl"],
      createdAt: snapshot["createdAt"],
      likes: List.from(snap.get("likes")),
      totalReplies: snapshot["totalReplies"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "commentId": commentId,
      "postId": postId,
      "creatorUid": creatorUid,
      "description": description,
      "userName": userName,
      "userProfileUrl": userProfileUrl,
      "createdAt": createdAt,
      "likes": likes,
      "totalReplies": totalReplies,
    };
  }
}
