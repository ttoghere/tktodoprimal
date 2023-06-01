import 'package:flutter/material.dart';
import 'package:tktodoprimal/pages/auth/sign_in_page.dart';
import 'package:tktodoprimal/pages/home/home_page.dart';
import 'package:tktodoprimal/repositories/auth/auth_repository.dart';

class SplashPage extends StatefulWidget {
  static const routeName = "/";
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  AuthRepository authRepository = AuthRepository();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: authRepository.getLoginState(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          // User is logged in, navigate to home screen
          return HomePage();
        } else {
          // User is not logged in, show login form
          return SignInPage();
        }
      },
    );
  }
}
