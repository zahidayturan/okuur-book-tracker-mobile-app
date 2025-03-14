import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:okuur/core/utils/firebase_firestore_helper.dart';
import 'package:okuur/core/utils/firebase_google_helper.dart';

class FirebaseAuthOperation{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      //User? user = result.user;
      await sendVerification();
      return 'Ok';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'email-already-in-use';
      } else {
        return 'Error: ${e.message}';
      }
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  Future<void> sendVerification() async {
    if (_auth.currentUser != null && _auth.currentUser!.emailVerified == false) {
      try {
        await _auth.currentUser?.sendEmailVerification();
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> userDelete() async {
    print("silinecek");
    if (_auth.currentUser != null) {
      try {
        await _auth.currentUser!.delete();
        print("silindi");
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> deleteAccountAndSignOut() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.delete();
        await FirebaseGoogleOperation().signOutGoogle();
        await userSignOut();
      }
    } catch (e) {
      print("Error deleting account: $e");
    }
  }

  Future<void> userSignOut() async {
    if (_auth.currentUser != null) {
      try {
        await _auth.signOut();
      } catch (e) {
        print(e.toString());
      }
    }
  }


  Future<String> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      if (user != null) {
        if (!user.emailVerified) {
          await userDelete();
          return 'email-not-verified';
        }
        return 'Ok';
      } else {
        return 'user-not-found';
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if (e.code == 'user-not-found') {
        return 'user-not-found';
      } else if (e.code == 'wrong-password') {
        return 'wrong-password';
      } else {
        return 'Error: ${e.message}';
      }
    } catch (e) {
      print(e.toString());
      return 'Error: ${e.toString()}';
    }
  }


  Future<bool> isEmailRegistered(String email,String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (result.user != null) {
        await result.user!.delete();
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<String> checkSignInMethod() async {
    User? user = _auth.currentUser;
    if (user != null) {
      for (var provider in user.providerData) {
        if (provider.providerId == 'google.com') {
          print('User signed in with Google');
          return "Google";
        } else if (provider.providerId == 'password') {
          print('User signed in with Email/Password');
          return "Email/Password";
        }
      }
    }
    return "User Not Found";
  }

  Future<String> checkUserInfoInFirestore() async {
    User? user = _auth.currentUser;
    if (user != null) {
      var userInfo = await FirebaseFirestoreOperation().getUserInfo(user.uid);
      if (userInfo != null) {
        return "ok";
      } else {
        return "no";
      }
    }
    return "no";
  }

}
