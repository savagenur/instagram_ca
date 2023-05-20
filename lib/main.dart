import 'package:flutter/material.dart';
import 'package:instagram_ca/features/presentation/pages/credentials/sign_in_page.dart';
import 'package:instagram_ca/features/presentation/pages/main_screen/main_screen.dart';
import 'package:instagram_ca/on_generate_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(),
      onGenerateRoute: OnGenerateRoute.route,
      initialRoute: "/",
      routes: {
        "/": (context) => SignInPage(),
      },
    );
  }
}
