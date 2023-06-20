import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_ca/constants.dart';
import 'package:instagram_ca/features/domain/entities/app_entity.dart';
import 'package:instagram_ca/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_ca/features/domain/entities/user/user_entity.dart';
import 'package:instagram_ca/features/presentation/cubit/comment/cubit/comment_cubit.dart';
import 'package:instagram_ca/features/presentation/cubit/post/get_single_post/cubit/get_single_post_cubit.dart';
import 'package:instagram_ca/features/presentation/cubit/user/get_single_user/cubit/get_single_user_cubit.dart';
import 'package:instagram_ca/features/presentation/pages/post/comment/widgets/single_comment_widget.dart';
import 'package:instagram_ca/features/presentation/widgets/form_container_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../profile_widget.dart';
import '../update_comment_page.dart';

class CommentMainWidget extends StatefulWidget {
  final AppEntity appEntity;
  const CommentMainWidget({super.key, required this.appEntity});

  @override
  State<CommentMainWidget> createState() => _CommentMainWidgetState();
}

class _CommentMainWidgetState extends State<CommentMainWidget> {
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CommentCubit>(context)
        .getComments(postId: widget.appEntity.postId!);
    BlocProvider.of<GetSingleUserCubit>(context)
        .getSingleUser(uid: widget.appEntity.uid!);
    BlocProvider.of<GetSinglePostCubit>(context)
        .getSinglePost(postId: widget.appEntity.postId!);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
            )),
        title: const Text("Comments"),
      ),
      body: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, singleUserState) {
          if (singleUserState is GetSingleUserLoaded) {
            final singleUser = singleUserState.userEntity;
            return BlocBuilder<CommentCubit, CommentState>(
              builder: (context, commentState) {
                if (commentState is CommentLoaded) {
                  return BlocBuilder<GetSinglePostCubit, GetSinglePostState>(
                    builder: (context, getSinglePostState) {
                      if (getSinglePostState is GetSinglePostLoaded) {
                        final singlePost = getSinglePostState.postEntity;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: profileWidget(
                                              imageUrl:
                                                  singlePost.userProfileUrl),
                                        ),
                                      ),
                                      sizeHor(10),
                                      Text(
                                        singlePost.userName!,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      sizeHor(10),
                                    ],
                                  ),
                                  sizeVer(10),
                                  Text(
                                    singlePost.description!,
                                    style: TextStyle(color: primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            sizeVer(10),
                            const Divider(
                              color: secondaryColor,
                            ),
                            sizeVer(10),
                            Expanded(
                              child: ListView.builder(
                                itemCount: commentState.comments.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final singleComment =
                                      commentState.comments[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: SingleCommentWidget(
                                      comment: singleComment,
                                      onLongPressListener: () {
                                        _openBottomModalSheet(
                                            context, singleComment);
                                      },
                                      onLikeListener: () {
                                        _likeComment(
                                            commentEntity: singleComment);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            _commentSection(currentUser: singleUser),
                          ],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _commentSection({required UserEntity currentUser}) {
    return Container(
      width: double.infinity,
      height: 55,
      color: Colors.grey[800],
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: profileWidget(imageUrl: currentUser.profileUrl),
            ),
          ),
          sizeHor(10),
          Expanded(
            child: TextFormField(
              controller: _descriptionController,
              style: const TextStyle(
                color: primaryColor,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Post your comment...",
                hintStyle: TextStyle(color: secondaryColor),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _createComment(currentUser);
            },
            child: Text(
              "Post",
              style: TextStyle(
                fontSize: 15,
                color: blueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _openBottomModalSheet(BuildContext context, CommentEntity commentEntity) {
    return showBarModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            decoration: BoxDecoration(
              color: backgroundColor.withOpacity(.8),
            ),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(
                        "More options",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    sizeVer(8),
                    const Divider(
                      thickness: 1,
                      color: secondaryColor,
                    ),
                    sizeVer(8),
                    GestureDetector(
                      onTap: () {
                        _deleteComment(
                          commentId: commentEntity.commentId!,
                          postId: commentEntity.postId!,
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 10),
                        child: const Text(
                          "Delete Comment",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                    sizeVer(7),
                    const Divider(
                      thickness: 1,
                      color: secondaryColor,
                    ),
                    sizeVer(7),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                            context, PageConst.updateCommentPage,
                            arguments: UpdateCommentPage(
                              commentEntity: commentEntity,
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: const Text(
                          "Update Comment",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _createComment(UserEntity currentUser) {
    FocusScope.of(context).unfocus();

    BlocProvider.of<CommentCubit>(context)
        .createComment(
      commentEntity: CommentEntity(
        commentId: Uuid().v1(),
        createdAt: Timestamp.now(),
        totalReplies: 0,
        likes: [],
        creatorUid: currentUser.uid,
        userName: currentUser.userName,
        description: _descriptionController.text,
        postId: widget.appEntity.postId,
        userProfileUrl: currentUser.profileUrl,
      ),
    )
        .then((value) {
      setState(() {
        _descriptionController.clear();
      });
    });
  }

  _deleteComment({required String commentId, required String postId}) {
    BlocProvider.of<CommentCubit>(context).deleteComment(
      commentEntity: CommentEntity(
        commentId: commentId,
        postId: postId,
      ),
    );
  }

  _likeComment({required CommentEntity commentEntity}) {
    BlocProvider.of<CommentCubit>(context).likeComment(
      commentEntity: CommentEntity(
        commentId: commentEntity.commentId,
        postId: commentEntity.postId,
      ),
    );
  }
}
