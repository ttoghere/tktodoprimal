// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tktodoprimal/pages/auth/mobile_auth_page.dart';

import 'package:tktodoprimal/pages/auth/sign_up_page.dart';

import 'widgets/widgets.dart';

class SignInPage extends StatefulWidget {
  static const routeName = "/signin";
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: const LoginBody(),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign In",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              ActionButtons(
                type: false,
              ),
              MultipleUserForm(type: false),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionButtons extends StatefulWidget {
  final bool type;
  const ActionButtons({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        CustomSocialLoginButton(
          assetPath: "assets/google.svg",
          title: "Continue with Google",
          onTap: () {},
        ),
        const SizedBox(
          height: 10,
        ),
        CustomSocialLoginButton(
          assetPath: "assets/phone.svg",
          title: "Continue with Phone",
          onTap: () {
            Navigator.of(context).pushNamed(MobileAuthPage.routeName);
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
