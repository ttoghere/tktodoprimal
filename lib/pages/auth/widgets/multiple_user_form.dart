import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tktodoprimal/repositories/auth/auth_repository.dart';

class MultipleUserForm extends StatefulWidget {
  final bool type;
  /*
  true == SignUp Form
  false == Login Form
   */
  const MultipleUserForm({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  State<MultipleUserForm> createState() => _MultipleUserFormState();
}

class _MultipleUserFormState extends State<MultipleUserForm> {
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
          GestureDetector(
            onTap: widget.type
                ? () {
                    AuthRepository().signUp(
                        email: _emailController.text,
                        password: _passwordController.text);
                  }
                : () {
                    log("Logged In");
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
              child: Center(
                child: Text(
                  widget.type ? "Sign Up" : "Sign In",
                  style: const TextStyle(
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
        ],
      ),
    );
  }
}
