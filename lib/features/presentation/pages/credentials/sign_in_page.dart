import 'package:flutter/material.dart';
import 'package:instagram_ca/constants.dart';
import 'package:instagram_ca/features/presentation/widgets/button_container_widget.dart';
import 'package:instagram_ca/features/presentation/widgets/form_container_widget.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
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
             const FormContainerWidget(
              hintText: "Email",
            ),
            sizeVer(15),
            const FormContainerWidget(
              hintText: "Password",
              isPasswordField: true,
            ),
            sizeVer(15),
            ButtonContainerWidget(
              color: blueColor,
              text: "Sign In",
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
                const Text("Don't have an account? ",style: TextStyle(color: primaryColor,),)
                ,InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        PageConst.signUpPage,
                        (route) => false);
                  },
                  child: const Text("Sign Up.",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,

                  ),),
                   
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
