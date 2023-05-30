// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tktodoprimal/pages/auth/sign_in_page.dart';
import 'package:tktodoprimal/repositories/auth/auth_repository.dart';
import 'widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = "/signup";
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty) {
      return "Email is required";
    }
    //RegExp için tasarım örneği
    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail)) return "Invalid email adress";
    return null;
  }

  String? validatePassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty) {
      return "Password is required";
    }
    String pattern = r'^.{8,}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(formPassword)) {
      /*
        r'^
          (?=.*[A-Z])       // should contain at least one upper case
          (?=.*[a-z])       // should contain at least one lower case
          (?=.*?[0-9])      // should contain at least one digit
          (?=.*?[!@#\$&*~]) // should contain at least one Special character
          .{8,}             // Must be at least 8 characters in length  
        $ 
       * 
      */
      return '''
			Password must be at least 8 characters,
			''';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
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
                onTap: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Or...",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: _emailForm(context),
              ),
              GestureDetector(
                onTap: () {
                  AuthRepository().signUp(
                      email: _emailController.text,
                      password: _passwordController.text);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 35, right: 35, top: 25),
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        Colors.red[700]!,
                        Colors.red[500]!,
                        Colors.red[300]!,
                        Colors.red[100]!
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              IfAlreadyRouter(
                title: "If you already have an Account?",
                text: "Login",
                onTap: () {
                  Navigator.of(context).pushNamed(SignInPage.routeName);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Form _emailForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _emailController,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                labelText: "Enter your Email",
                labelStyle: TextStyle(color: Colors.white),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              obscureText: true,
              controller: _passwordController,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                labelText: "Enter your Password",
                labelStyle: TextStyle(color: Colors.white),
              ),
              validator: validatePassword,
            ),
          ),
        ],
      ),
    );
  }
}
