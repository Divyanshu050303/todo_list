import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:todo_list/common/services/shared_preference.dart';

class Authentication {
  customSharePreference customPref = customSharePreference();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(
      String email, String password, BuildContext context) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      customPref.saveData("logIn", "loggedIn");

      context.push("/home");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sign up successful')));
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else {
        message = 'An error occurred. Please try again.';
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred. Please try again.')));
    }
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sign in successful')));
      customPref.saveData("logIn", "loggedIn");

      context.push("/home");
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else {
        message = 'An error occurred. Please try again.';
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred. Please try again.')));
    }
  }

  void logout(BuildContext context) async {
    FirebaseAuth.instance.signOut();
    customPref.removeSharedPreference('logIn');
    context.push("/auth");
    print("Logout successfully");
  }
}
