import 'package:flutter/material.dart';
import 'package:instagram_ca/constants.dart';

class ProfileFormWidget extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  const ProfileFormWidget(
      {super.key, required this.title, this.controller,});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: primaryColor,
            fontSize: 16,
          ),
        ),
        sizeVer(10),
        TextFormField(
          controller: controller,
          style: const TextStyle(color: primaryColor),
          decoration: InputDecoration(
            border: InputBorder.none,
            labelStyle: TextStyle(color: primaryColor),
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: secondaryColor ,
        )
      ],
    );
  }
}
