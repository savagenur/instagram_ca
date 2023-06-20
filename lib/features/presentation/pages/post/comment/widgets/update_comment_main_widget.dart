import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:instagram_ca/constants.dart';
import 'package:instagram_ca/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_ca/features/presentation/cubit/comment/cubit/comment_cubit.dart';
import 'package:instagram_ca/features/presentation/pages/profile/widgets/profile_form_widget.dart';
import 'package:instagram_ca/features/presentation/widgets/button_container_widget.dart';

class UpdateCommentMainWidget extends StatefulWidget {
  final CommentEntity commentEntity;
  const UpdateCommentMainWidget({
    Key? key,
    required this.commentEntity,
  }) : super(key: key);

  @override
  State<UpdateCommentMainWidget> createState() =>
      _UpdateCommentMainWidgetState();
}

class _UpdateCommentMainWidgetState extends State<UpdateCommentMainWidget> {
  late TextEditingController _descriptionController;
  bool _isCommentUpdating = false;
  @override
  void initState() {
    super.initState();
    _descriptionController =
        TextEditingController(text: widget.commentEntity.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text("Edit Comment"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ProfileFormWidget(
              title: "Description",
              controller: _descriptionController,
            ),
            sizeVer(10),
            ButtonContainerWidget(
              text: "Save Changes",
              color: blueColor,
              onTapListener: _updateComment,
            )
          ,
          sizeVer(10),
         _isCommentUpdating? Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Updating", style: TextStyle(color: primaryColor,),)
              ,sizeHor(10),
              CircularProgressIndicator(),
            ],
          ):Container(),
          ],
        ),
      ),
    );
  }

  _updateComment() {
    setState(() {
      _isCommentUpdating = true;
    });
    BlocProvider.of<CommentCubit>(context).updateComment(
        commentEntity: CommentEntity(
      commentId: widget.commentEntity.commentId,
      postId: widget.commentEntity.postId,
      description: _descriptionController.text,
    ));
    setState(() {
      _isCommentUpdating = false;
      _descriptionController.clear();
    });
    Navigator.pop(context);
  }
}
