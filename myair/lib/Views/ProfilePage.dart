
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:myair/Modules/UserAccount.dart';
import 'package:myair/Services/Database_service/FirebaseDatabaseHelper.dart';
import 'package:myair/Services/Google_Service/GoogleSignIn.dart';
import 'package:myair/Widgets/Login_with_google/SignUpWidget.dart';
import 'package:myair/Views/HomePage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../main.dart';

//like a router that check if the user has logged with a google account and in case it fire it in the hoem page
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final provider = Provider.of<GoogleSignInProvider>(context);
          if (provider.isSigningIn) {
            return buildLoading();

          } else if (snapshot.hasData) {
            print("sono qiijdi");
            var x =  FirebaseAuth.instance.currentUser;
            var namesur = x.displayName.split(" ");
          actualUser = new UserAccount(namesur.elementAt(0), namesur.elementAt(1), x.email, "",null,[100,50,400,500,240,10], true,true,DateFormat('MM-dd').format(DateTime.now()),0,true,0);
          FirebaseDatabaseHelper().saveGoogleUser(actualUser);
            return HomePage();
          }else{
            return SignUpWidget();
          }
        },
      ),
    ),
  );
  Widget buildLoading() => Stack(
    fit: StackFit.expand,

    children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: null,
      ),
      Center(child: CircularProgressIndicator()),
    ],
  );

}
