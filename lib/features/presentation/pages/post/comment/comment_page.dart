import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_ca/features/presentation/cubit/comment/cubit/comment_cubit.dart';
import 'package:instagram_ca/features/presentation/cubit/user/get_single_user/cubit/get_single_user_cubit.dart';
import 'package:instagram_ca/features/presentation/pages/post/comment/widgets/comment_main_widget.dart';

import '../../../../domain/entities/app_entity.dart';
import 'package:instagram_ca/injection_container.dart' as di;

import '../../../cubit/post/get_single_post/cubit/get_single_post_cubit.dart';

class CommentPage extends StatelessWidget {
  final AppEntity appEntity;
  const CommentPage({super.key, required this.appEntity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<GetSingleUserCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<CommentCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<GetSinglePostCubit>(),
        ),
      ],
      child: CommentMainWidget(appEntity: appEntity),
    );
  }
}
