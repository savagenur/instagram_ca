import 'package:flutter/material.dart';
import 'package:instagram_ca/constants.dart';
import 'package:instagram_ca/features/presentation/widgets/button_container_widget.dart';
import 'package:instagram_ca/features/presentation/widgets/form_container_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding:const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            const Center(
              child: Text("Instagram",style: TextStyle(color: primaryColor,fontSize: 23),),
            ),
            sizeVer(30),
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: secondaryColor,
                    ),
                    child: Image.asset("assets/profile_default.png"),
                  ),
                  Positioned(
                    right: -5,
                    bottom: -5,
                    child: GestureDetector(
                      onTap: () {
                        
                      },
                      child: const Icon(Icons.photo_camera_rounded,color: blueColor,),))
                ],
              ),
            ),
            sizeVer(30),

            const FormContainerWidget(
              hintText: "Username",
            ),
            sizeVer(15),
            const FormContainerWidget(
              hintText: "Email",
            ),
            sizeVer(15),
            const FormContainerWidget(
              hintText: "Password",
              isPasswordField: true,
            ),
            sizeVer(15),
            const FormContainerWidget(
              hintText: "Bio",
            ),
            sizeVer(15),
            ButtonContainerWidget(
              color: blueColor,
              text: "Sign Up",
              onTapListener: () {},
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            const Divider(
              color: secondaryColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        PageConst.signInPage,
                        (route) => false);
                  },
                  child: const Text(
                    "Sign In.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
