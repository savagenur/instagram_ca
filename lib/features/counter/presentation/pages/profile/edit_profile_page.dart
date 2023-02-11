import 'package:flutter/material.dart';
import 'package:instagram_ca/constants.dart';
import 'package:instagram_ca/features/counter/presentation/pages/profile/widgets/profile_form_widget.dart';

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
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.close,
              size: 32,
            )),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: 10,
            ),
            child: Icon(
              Icons.done,
              color: blueColor,
              size: 32,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView  (
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(60)),
                ),
              ),
              sizeVer(15),
              Center(
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
              ProfileFormWidget(title: "Name"),
              sizeVer(15),
              ProfileFormWidget(title: "Username"),
              sizeVer(15),
              ProfileFormWidget(title: "Website"),
              sizeVer(15),
              ProfileFormWidget(title: "Bio"),
              sizeVer(15),
              ProfileFormWidget(title: "Name"),
            ],
          ),
        ),
      ),
    );
  }
}
