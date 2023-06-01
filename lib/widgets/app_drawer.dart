import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tktodoprimal/repositories/auth/auth_repository.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});
  AuthRepository authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await authRepository.setLoginState(false);
            },
            child: Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}
