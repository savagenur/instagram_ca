import 'package:flutter/material.dart';
import 'package:instagram_ca/constants.dart';
import 'package:instagram_ca/features/domain/entities/user/user_entity.dart';
import 'package:instagram_ca/features/presentation/pages/post/update_post_page.dart';
import 'package:instagram_ca/features/presentation/pages/profile/edit_profile_page.dart';

import 'features/presentation/pages/credentials/sign_in_page.dart';
import 'features/presentation/pages/credentials/sign_up_page.dart';
import 'features/presentation/pages/post/comment/comment_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    dynamic args = settings.arguments;
    switch (settings.name) {
      case PageConst.editProfilePage:
        if (args is UserEntity) {
          return routeBuilder(EditProfilePage(currentUser: args));
        } else {
          return routeBuilder(NoPageFound());
        }
      case PageConst.updatePostPage:
        args = args as UpdatePostPage;
        return routeBuilder(UpdatePostPage(
          postEntity: args.postEntity,
        ));
      case PageConst.commentPage:
        return routeBuilder(CommentPage());
      case PageConst.signInPage:
        return routeBuilder(SignInPage());
      case PageConst.signUpPage:
        return routeBuilder(SignUpPage());
      default:
        {
          NoPageFound();
        }
    }
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(
    builder: (context) => child,
  );
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Page not found",
          style: TextStyle(
            color: primaryColor,
          ),
        ),
      ),
      backgroundColor: secondaryColor,
      body: Center(
        child: Text(
          "Page not found!",
          style: TextStyle(
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
