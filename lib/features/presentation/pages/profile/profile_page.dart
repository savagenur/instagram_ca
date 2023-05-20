import 'package:instagram_ca/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          "Username",
          style: TextStyle(
            color: primaryColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: InkWell(
              onTap: () {
                _openBottomModalSheet(context);
              },
              child: const Icon(
                Icons.menu,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          const Text(
                            "0",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          sizeVer(5),
                          const Text(
                            "Post",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      sizeHor(25),
                      Column(
                        children: [
                          const Text(
                            "24",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          sizeVer(5),
                          const Text(
                            "Followers",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      sizeHor(25),
                      Column(
                        children: [
                          const Text(
                            "123",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          sizeVer(5),
                          const Text(
                            "Followings",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              sizeVer(10),
              const Text(
                "Name",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sizeVer(10),
              const Text(
                "The bio of user ",
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
              sizeVer(10),
              GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: 32,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: secondaryColor,
                  );
                },
              )
            ],
          ),
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
                      onTap: () {
                        Navigator.pushNamed(context, PageConst.editProfilePage);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 10),
                        child: const Text(
                          "Edit Profile",
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
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
