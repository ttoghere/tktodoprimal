import 'package:flutter/material.dart';
import 'package:tktodoprimal/pages/auth/forget_pass_page.dart';
import 'package:tktodoprimal/pages/auth/sign_in_page.dart';
import 'package:tktodoprimal/pages/auth/sign_up_page.dart';
import 'package:tktodoprimal/pages/home/home_page.dart';
import 'package:tktodoprimal/pages/splash/splash_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        SplashPage.routeName:(context) => const SplashPage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        SignInPage.routeName: (context) => const SignInPage(),
        ForgetPassPage.routeName: (context) => const ForgetPassPage(),
        HomePage.routeName: (context) => const HomePage(),
      },
      initialRoute: SplashPage.routeName,
    );
  }
}
