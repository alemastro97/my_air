import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myair/Modules/UserAccount.dart';
import 'package:myair/Services/Database_service/firebase_database_user.dart';
import 'package:myair/main.dart';
import 'package:http/http.dart' as http;
class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future login() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      isSigningIn = false;
      var x =  FirebaseAuth.instance.currentUser;
      var namesur = x.displayName.split(" ");
      var b = ( await http.get(x.photoURL)).bodyBytes;
      var image   = b!= null ?  base64Encode(b):"";
      actualUser = new userAccount(namesur.elementAt(0), namesur.elementAt(1), x.email, "",image);
      FirebaseDb_gesture().saveGoogleUser(actualUser);
    }
  }

  void logout() async {
    print('logout entered');
      await googleSignIn.disconnect().whenComplete(() async {
        FirebaseAuth.instance.signOut();
      });

  }
}