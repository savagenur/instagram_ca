import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_ca/features/domain/entities/app_entity.dart';
import 'package:instagram_ca/features/domain/entities/post/post_entity.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:instagram_ca/features/presentation/cubit/post/cubit/post_cubit.dart';
import 'package:instagram_ca/features/presentation/pages/post/comment/comment_page.dart';
import 'package:instagram_ca/features/presentation/pages/post/update_post_page.dart';
import 'package:instagram_ca/features/presentation/pages/post/widget/like_animation_widget.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:instagram_ca/injection_container.dart' as di;

import '../../../../../constants.dart';
import '../../../../../profile_widget.dart';

class SinglePostCardWidget extends StatefulWidget {
  final PostEntity postEntity;
  const SinglePostCardWidget({super.key, required this.postEntity});

  @override
  State<SinglePostCardWidget> createState() => _SinglePostCardWidgetState();
}

class _SinglePostCardWidgetState extends State<SinglePostCardWidget> {
  bool _isLikeAnimating = false;
  late String _currentUid;
  @override
  void initState() {
    _currentUid = widget.postEntity.creatorUid!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: profileWidget(
                            imageUrl: "${widget.postEntity.userProfileUrl}"),
                      ),
                    ),
                    sizeHor(10),
                    Text(
                      widget.postEntity.userName!,
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      _openBottomModalSheet(context, widget.postEntity);
                    },
                    child: const Icon(
                      Icons.more_vert,
                      color: primaryColor,
                    )),
              ],
            ),
            sizeVer(10),
            GestureDetector(
              onDoubleTap: () {
                _likePost();
                setState(() {
                  _isLikeAnimating = true;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .3,
                    child: profileWidget(
                        imageUrl: "${widget.postEntity.postImageUrl}"),
                  ),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 200),
                    opacity: _isLikeAnimating ? 1 : 0,
                    child: LikeAnimationWidget(
                        duration: Duration(milliseconds: 300),
                        isLikeAnimating: _isLikeAnimating,
                        onLikeFinish: () {
                          setState(() {
                            _isLikeAnimating = false;
                          });
                        },
                        child: Icon(
                          Icons.favorite,
                          size: 100,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
            sizeVer(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: _likePost,
                      child: Icon(
                        widget.postEntity.likes!.contains(_currentUid)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.postEntity.likes!.contains(_currentUid)
                            ? Colors.red
                            : primaryColor,
                      ),
                    ),
                    sizeHor(10),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, PageConst.commentPage,
                              arguments: AppEntity(
                                uid: _currentUid,
                                postId: widget.postEntity.postId,
                                postEntity: widget.postEntity,
                              )),
                      child: const Icon(
                        Icons.message,
                        color: primaryColor,
                      ),
                    ),
                    sizeHor(10),
                    const Icon(
                      Icons.send,
                      color: primaryColor,
                    ),
                    sizeHor(10),
                  ],
                ),
                const Icon(
                  Icons.bookmark_border,
                  color: primaryColor,
                )
              ],
            ),
            sizeVer(10),
            Text(
              "${widget.postEntity.totalLikes} likes",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            sizeVer(10),
            Row(
              children: [
                Text(
                  "${widget.postEntity.userName!}",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                sizeHor(10),
                Text(
                  "${widget.postEntity.description}",
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            sizeVer(10),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PageConst.commentPage,
                    arguments: AppEntity(
                      uid: _currentUid,
                      postId: widget.postEntity.postId,
                      postEntity: widget.postEntity,
                    ));
              },
              child: Text(
                "View all ${widget.postEntity.totalComments} comments",
                style: TextStyle(
                  color: darkGreyColor,
                ),
              ),
            ),
            sizeVer(10),
            Text(
              "${DateFormat("dd/MMM/yyy").format(widget.postEntity.createAt!.toDate())}",
              style: TextStyle(
                color: darkGreyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openBottomModalSheet(BuildContext context, PostEntity postEntity) {
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
                      onTap: _deletePost,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 10),
                        child: const Text(
                          "Delete Post",
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
                        Navigator.pushNamed(context, PageConst.updatePostPage,
                            arguments: UpdatePostPage(postEntity: postEntity));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: const Text(
                          "Update Post",
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

  _deletePost() {
    Navigator.pop(context);
    BlocProvider.of<PostCubit>(context)
        .deletePost(postEntity: PostEntity(postId: widget.postEntity.postId));
  }

  _likePost() {
    BlocProvider.of<PostCubit>(context).likePost(
        postEntity: PostEntity(
      postId: widget.postEntity.postId,
    ));
  }
}
