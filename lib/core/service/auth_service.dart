import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
 String? userEmail;

class AuthServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password) async {
    try {
      final userData = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userData.user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.message!);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<UserCredential> login(String email, String password) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email).whenComplete(() {
        if (kDebugMode) {
          print("A link is sent to your email.Please check your email "
            "inbox and spam.");
        }
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.message!);
      }
    }
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}