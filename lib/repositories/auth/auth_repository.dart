import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tktodoprimal/pages/home/home_page.dart';
import 'package:tktodoprimal/repositories/auth/base_auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseAuth _firebaseAuth;
  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  Future<void> signUp({required String email, required String password}) async {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => debugPrint(value.toString()));
  }

  @override
  Future<UserCredential> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      // Handle login errors
      log('Error logging in: $e');
      rethrow;
    }
  }

  @override
  Future<void> setLoginState(bool isLoggedIn) async {
    await storage.write(key: 'isLoggedIn', value: isLoggedIn.toString());
  }

  @override
  Future<bool> getLoginState() async {
    String? isLoggedIn = await storage.read(key: 'isLoggedIn');
    return isLoggedIn == 'true';
  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber, BuildContext context,
      void Function(dynamic verificationId) setData) async {
    verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
      showSnackbar(context, "Verification Completed");
    }

    verificationFailed(FirebaseAuthException firebaseAuthException) {
      showSnackbar(context, "Verification ${firebaseAuthException.toString()}");
    }

    codeSent(String verificationID, int? forceResendingToken) {
      setData(verificationID);
      showSnackbar(context, "Verification Code Sent To Your Phone Number");
    }

    codeAutoRetrievalTimeout(String verificationID) {
      showSnackbar(context, "Time Out");
    }

    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } on FirebaseAuthException catch (err) {
      showSnackbar(context, err.message.toString());
    }
  }

  @override
  void showSnackbar(BuildContext context, String text) {
    final snackbar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
