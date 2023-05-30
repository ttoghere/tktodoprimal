import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tktodoprimal/repositories/auth/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseAuth _firebaseAuth;
  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  @override
  Future<void> signUp({required String email, required String password}) async{
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => debugPrint(value.toString()));
  }
}
