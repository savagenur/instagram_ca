import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_ca/features/domain/entities/post/post_entity.dart';
import 'package:instagram_ca/features/presentation/cubit/post/cubit/post_cubit.dart';
import 'package:instagram_ca/features/presentation/pages/post/update_post_page.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../constants.dart';
import '../../../../../profile_widget.dart';

class SinglePostCardWidget extends StatefulWidget {
  final PostEntity postEntity;
  const SinglePostCardWidget({super.key, required this.postEntity});

  @override
  State<SinglePostCardWidget> createState() => _SinglePostCardWidgetState();
}

class _SinglePostCardWidgetState extends State<SinglePostCardWidget> {
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
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .3,
              child:
                  profileWidget(imageUrl: "${widget.postEntity.postImageUrl}"),
            ),
            sizeVer(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: primaryColor,
                    ),
                    sizeHor(10),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, PageConst.commentPage),
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
            Text(
              "View all ${widget.postEntity.totalComments} comments",
              style: TextStyle(
                color: darkGreyColor,
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
}
