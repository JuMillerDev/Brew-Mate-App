import 'package:brew_maate/models/user_custom.dart';
import 'package:brew_maate/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create User object based on Firebase User
  UserCustom? _userFromFirebase(User? user) {
    return user != null ? UserCustom(uid: user.uid) : null;
  }

  //auth change user Stream
  Stream<UserCustom?> get user {
    return _auth
        .authStateChanges()
        //longer method
        //.map((User? user) => _userFromFirebase(user));
        .map(_userFromFirebase);
  }

  //sign in anonymously method
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      //create a new document for user with the uid
      await DatabaseService(uid: user!.uid)
          .updateUserData('0', 'new member', 100);
      return _userFromFirebase(user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
