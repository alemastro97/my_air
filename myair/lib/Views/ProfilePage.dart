
import 'package:myair/Services/Google_Service/GoogleSignIn.dart';
import 'package:myair/Widgets/Login_with_google/SignUpWidget.dart';
import 'package:myair/Views/HomePage.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

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
