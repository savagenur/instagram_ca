import 'package:flutter/material.dart';
import 'package:instagram_ca/constants.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Activity',style: TextStyle(color: primaryColor),),
      ),
    );
  }
}