import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ReplyEntity extends Equatable {
  final String? replyId;
  final Timestamp? createdAt;
  final String? userName;
  final String? description;
  final String? creatorUid;
  final String? commentId;

  final String? postId;
  final String? userProfileUrl;
  final List<String>? likes;
  ReplyEntity({
    this.replyId,
    this.createdAt,
    this.userName,
    this.description,
    this.creatorUid,
    this.commentId,
    this.postId,
    this.userProfileUrl,
    this.likes,
  });

  @override
  List<Object?> get props => [
        replyId,
        createdAt,
        userName,
        description,
        creatorUid,
        commentId,
        postId,
        userProfileUrl,
        likes,
      ];
}
