import 'package:flutter/material.dart';

abstract class BaseAuthRepository {
  Future<void> signUp({required String email, required String password});
  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext context});
  Future<bool> getLoginState();
  Future<void> setLoginState(bool isLoggedIn);
  Future<void> verifyPhoneNumber(String phoneNumber, BuildContext context,
      void Function(dynamic verificationId) setData);
  void showSnackbar(BuildContext context, String text);
}
