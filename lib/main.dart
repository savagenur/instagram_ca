import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_ca/features/presentation/cubit/auth/cubit/auth_cubit.dart';
import 'package:instagram_ca/features/presentation/cubit/credential/cubit/credential_cubit.dart';
import 'package:instagram_ca/features/presentation/pages/credentials/sign_in_page.dart';
import 'package:instagram_ca/features/presentation/pages/main_screen/main_screen.dart';
import 'package:instagram_ca/on_generate_route.dart';
import 'features/presentation/cubit/user/cubit/user_cubit.dart';
import 'features/presentation/cubit/user/get_single_user/cubit/get_single_user_cubit.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted(context),),
        BlocProvider(create: (_) =>di.sl<CredentialCubit>() ,),
        BlocProvider(create: (_) =>di.sl<UserCubit>() ,),
        BlocProvider(create: (_) =>di.sl<GetSingleUserCubit>() ,),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        darkTheme: ThemeData.dark(),
        onGenerateRoute: OnGenerateRoute.route,
        initialRoute: "/",
        routes: {
          "/": (context) => BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  if (authState is Authenticated) {
                    return MainScreen(
                      uid: authState.uid,
                    );
                  } else {
                    return SignInPage();
                  }
                },
              ),
        },
      ),
    );
  }
}
