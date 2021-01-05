import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:myair/Modules/UserAccount.dart';
import 'package:myair/Services/Database_service/firebase_database_user.dart';
import 'package:myair/Services/Google_Service/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:myair/Widgets/Login_with_google/sign_up_widget.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
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
            print("BuildLoadinf");
            return buildLoading();
          } else if (snapshot.hasData) {
            //TODO insert await
            print(snapshot.toString());
            print("----------------------------------------------------------------------------------------------------------------------------------------------------------");
            ///setUser();
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
//TODO sistemare
  Future<void> setUser() async {
    var x =  FirebaseAuth.instance.currentUser;
    var namesur = x.displayName.split(" ");
    print("SetUser: " + namesur.elementAt(0) + " " + namesur.elementAt(1));
    var b = ( await http.get(x.photoURL)).bodyBytes;
    var image   = b!= null ?  base64Encode(b) : "";
    print("£sdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
    actualUser = new userAccount(namesur.elementAt(0), namesur.elementAt(1), x.email, "",image);
    FirebaseDb_gesture().saveGoogleUser(actualUser);
  }
}
