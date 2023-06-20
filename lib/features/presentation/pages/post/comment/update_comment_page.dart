import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_ca/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_ca/features/presentation/cubit/comment/cubit/comment_cubit.dart';
import 'package:instagram_ca/features/presentation/pages/post/comment/widgets/update_comment_main_widget.dart';
import 'package:instagram_ca/injection_container.dart' as di;
class UpdateCommentPage extends StatelessWidget {
  final CommentEntity commentEntity;
  const UpdateCommentPage({super.key, required this.commentEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<CommentCubit>(),
      child: UpdateCommentMainWidget(commentEntity: commentEntity),
    );
  }
}
