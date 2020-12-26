import 'package:firebase_auth/firebase_auth.dart';
import 'package:myair/Services/Google_Service/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:myair/Widgets/Login_with_google/sign_up_widget.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'home_page.dart';

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
          } else if( logged == true){
            return HomePage();
          }else{
            print('Arrivo');
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
