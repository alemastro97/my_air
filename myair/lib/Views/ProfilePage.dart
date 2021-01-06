
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myair/Services/Google_Service/GoogleSignIn.dart';
import 'package:flutter/material.dart';
import 'package:myair/Widgets/Login_with_google/SignUpWidget.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';

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
      //CustomPaint(painter: BackgroundPainter()),
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
