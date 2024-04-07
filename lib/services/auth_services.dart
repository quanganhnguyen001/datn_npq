// ignore_for_file: use_build_context_synchronously

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  static Future<Either<String, UserCredential>> login(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? '');
    }
  }

  static Future<Either<String, UserCredential>> signUp(
      {required String email,
      required String password,
      required BuildContext ctx}) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return Left('Email đã được sử dụng');
      } else {
        return Left(e.message ?? '');
      }
    }
  }
}
