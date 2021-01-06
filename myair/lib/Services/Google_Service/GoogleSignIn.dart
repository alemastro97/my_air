import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myair/Modules/UserAccount.dart';
import 'package:myair/Services/Database_service/FirebaseDatabaseHelper.dart';
import 'package:myair/main.dart';
import 'package:http/http.dart' as http;

// Get the account google and register it in the application
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
      actualUser = new UserAccount(namesur.elementAt(0), namesur.elementAt(1), x.email, "",image);
      FirebaseDatabaseHelper().saveGoogleUser(actualUser);
    }
  }

  void logout() async {
    print('logout entered');
      await googleSignIn.disconnect().whenComplete(() async {
        FirebaseAuth.instance.signOut();
      });

  }
}