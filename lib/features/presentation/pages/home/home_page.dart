import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_ca/constants.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


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
              MaterialCommunityIcons.facebook_messenger,
              color: primaryColor,
            ),
          )
        ],
      ),
      body: Padding(
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
                      decoration: const BoxDecoration(
                        color: secondaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    sizeHor(10),
                    const Text(
                      "Username",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      _openBottomModalSheet(context);
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
              color: secondaryColor,
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
                      onTap: () => Navigator.pushNamed(context, PageConst.commentPage),
                      child: const Icon(
                        Feather.message_circle,
                        color: primaryColor,
                      ),
                    ),
                    sizeHor(10),
                    const Icon(
                      Feather.send,
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
            const Text(
              "134 likes",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            sizeVer(10),
            Row(
              children: [
                const Text(
                  "Username",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                sizeHor(10),
                const Text(
                  "some description",
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            sizeVer(10),
            const Text(
              "View all 10 comments",
              style: TextStyle(
                color: darkGreyColor,
              ),
            ),
            sizeVer(10),
            const Text(
              "08/07/2022",
              style: TextStyle(
                color: darkGreyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openBottomModalSheet(BuildContext context) {
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
                      onTap: () {},
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
                        Navigator.pushNamed(context, PageConst.updatePostPage);
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
}
