import 'package:flutter/material.dart';
import 'package:instagram_ca/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_ca/profile_widget.dart';
import 'package:intl/intl.dart';

import '../../../../../../constants.dart';
import '../../../../widgets/form_container_widget.dart';

class SingleCommentWidget extends StatefulWidget {
  final CommentEntity comment;
  final VoidCallback? onLongPressListener;
  final VoidCallback? onLikeListener;
  const SingleCommentWidget(
      {super.key, required this.comment, this.onLongPressListener, this.onLikeListener});

  @override
  State<SingleCommentWidget> createState() => _SingleCommentWidgetState();
}

class _SingleCommentWidgetState extends State<SingleCommentWidget> {
  bool _isUserReplying = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.onLongPressListener,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: profileWidget(imageUrl: widget.comment.userProfileUrl),
              ),
            ),
            sizeHor(10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.comment.userName!,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.onLikeListener,
                          child: Icon(
                           widget.comment.likes!.contains(widget.comment.creatorUid)? Icons.favorite:Icons.favorite_outline,
                            size: 22,
                            color:widget.comment.likes!.contains(widget.comment.creatorUid)?Colors.red: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    sizeVer(4),
                    Text(
                      widget.comment.description!,
                      style: TextStyle(color: primaryColor),
                    ),
                    sizeVer(4),
                    Row(
                      children: [
                        Text(
                          DateFormat("dd/MMM/yyy")
                              .format(widget.comment.createdAt!.toDate()),
                          style: TextStyle(
                            color: darkGreyColor,
                            fontSize: 12,
                          ),
                        ),
                        sizeHor(15),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isUserReplying = !_isUserReplying;
                            });
                          },
                          child: const Text(
                            "Reply",
                            style: TextStyle(
                              color: darkGreyColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        sizeHor(15),
                        const Text(
                          "View Replies",
                          style: TextStyle(
                            color: darkGreyColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    _isUserReplying ? sizeVer(10) : sizeVer(0),
                    _isUserReplying
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const FormContainerWidget(
                                hintText: "Post your reply...",
                              ),
                              sizeVer(10),
                              const Text(
                                "Post",
                                style: TextStyle(
                                  color: blueColor,
                                ),
                              )
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}
