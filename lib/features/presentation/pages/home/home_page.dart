import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_ca/constants.dart';
import 'package:instagram_ca/features/domain/entities/post/post_entity.dart';
import 'package:instagram_ca/features/presentation/cubit/post/cubit/post_cubit.dart';
import 'package:instagram_ca/features/presentation/pages/home/widgets/single_post_card_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:instagram_ca/injection_container.dart' as di;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: SvgPicture.asset(
          "assets/ic_instagram.svg",
          color: primaryColor,
          height: 35,
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.facebook,
              color: primaryColor,
            ),
          )
        ],
      ),
      body: BlocProvider<PostCubit>(
        create: (context) =>
            di.sl<PostCubit>()..getPosts(postEntity: PostEntity()),
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, postState) {
            if (postState is PostLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (postState is PostFailure) {
              toast("Something went wrong while creating post!");
            }
            if (postState is PostLoaded) {
              return postState.posts.isEmpty
                  ? _noPostsYetWidget()
                  : ListView.builder(
                      itemCount: postState.posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final postEntity = postState.posts[index];
                        return BlocProvider(
                          create: (context) => di.sl<PostCubit>(),
                          child: SinglePostCardWidget(postEntity: postEntity),
                        );
                      },
                    );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  _noPostsYetWidget() {
    return Center(
      child: Text("No posts yet!", style: TextStyle(color: Colors.white,fontSize: 20, fontStyle: FontStyle.italic,),),
    );
  }
}
