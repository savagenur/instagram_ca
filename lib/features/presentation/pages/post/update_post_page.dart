import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_ca/features/domain/entities/post/post_entity.dart';
import 'package:instagram_ca/features/presentation/cubit/post/cubit/post_cubit.dart';
import 'package:instagram_ca/features/presentation/pages/post/widget/update_post_main_widget.dart';
import 'package:instagram_ca/injection_container.dart' as di;

class UpdatePostPage extends StatelessWidget {
  final PostEntity postEntity;
  const UpdatePostPage({super.key, required this.postEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<PostCubit>(),
      child: UpdatePostMainWidget(postEntity: postEntity),
    );
  }
}
