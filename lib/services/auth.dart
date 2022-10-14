// ignore_for_file: avoid_print

import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object base on firebase
  Userr? _userFromeFirebaseUser(User? user) {
    return user != null ? Userr(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<Userr?> get user {
    return _auth.authStateChanges().map(_userFromeFirebaseUser);
  }

  // sign in anon2
  Future signInAnon() async {
    // return await FirebaseAuth.instance;
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromeFirebaseUser(user);
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  //sign in with email and password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromeFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      
     // create new document for the user with uid
      await DatabaseService(uid: user!.uid)
          .updateUserData('0', 'new crew member', 100);

      return _userFromeFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future? signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
