import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_ca/constants.dart';
import 'package:instagram_ca/features/presentation/cubit/user/get_single_user/cubit/get_single_user_cubit.dart';
import 'package:instagram_ca/features/presentation/pages/activity/activity_page.dart';
import 'package:instagram_ca/features/presentation/pages/post/upload_post_page.dart';
import 'package:instagram_ca/features/presentation/pages/profile/profile_page.dart';
import 'package:instagram_ca/features/presentation/pages/search/search_page.dart';

import '../home/home_page.dart';

class MainScreen extends StatefulWidget {
  final String uid;
  const MainScreen({super.key, required this.uid});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    _currentIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, getSingleUserState) {
        if (getSingleUserState is GetSingleUserLoaded) {
          final currentUser = getSingleUserState.userEntity;
          return Scaffold(
            backgroundColor: backgroundColor,
            bottomNavigationBar: CupertinoTabBar(
              onTap: navigationTapped,
              backgroundColor: backgroundColor,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: primaryColor,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                      color: primaryColor,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: primaryColor,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite,
                      color: primaryColor,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.account_circle_outlined,
                      color: primaryColor,
                    ),
                    label: ''),
              ],
            ),
            body: PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: [
                HomePage(),
                SearchPage(),
                UploadPostPage(currentUser: currentUser,),
                ActivityPage(),
                ProfilePage(
                  currentUser: currentUser,
                ),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
