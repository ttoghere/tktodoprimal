import 'package:flutter/material.dart';

abstract class BaseAuthRepository {
  Future<void> signUp({required String email, required String password});
  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext context});
  Future<bool> getLoginState();
  Future<void> setLoginState(bool isLoggedIn);
}
