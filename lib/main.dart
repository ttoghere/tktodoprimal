import 'package:flutter/material.dart';
import 'package:tktodoprimal/pages/auth/forget_pass_page.dart';
import 'package:tktodoprimal/pages/auth/sign_in_page.dart';
import 'package:tktodoprimal/pages/auth/sign_up_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

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
        SignUpPage.routeName: (context) => const SignUpPage(),
        SignInPage.routeName: (context) => const SignInPage(),
        ForgetPassPage.routeName: (context) => const ForgetPassPage(),
      },
      initialRoute: SignUpPage.routeName,
    );
  }
}
