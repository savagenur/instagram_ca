import 'package:flutter/material.dart';
import 'package:instagram_ca/constants.dart';
import 'package:instagram_ca/features/presentation/pages/profile/widgets/profile_form_widget.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text("Edit Profile"),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.close)),
        actions: const[
           Padding(
            padding: EdgeInsets.only(
              right: 10,
            ),
            child: Icon(
              Icons.done,
              color: blueColor,
              size: 32,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
              ),
              sizeVer(15),
              const Center(
                child: Text(
                  "Change profile photo",
                  style: TextStyle(
                    color: blueColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
              sizeVer(15),
              const ProfileFormWidget(
                title: "Name",
              ),
              sizeVer(15),
              const ProfileFormWidget(
                title: "Username",
              ),
              sizeVer(15),
              const ProfileFormWidget(
                title: "Website",
              ),
              sizeVer(15),
              const ProfileFormWidget(
                title: "Bio",
              ),
              sizeVer(15),
              
            ],
          ),
        ),
      ),
    );
  }
}
 