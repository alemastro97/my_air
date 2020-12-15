import 'package:firebase_auth/firebase_auth.dart';
import 'package:myair/provider/google_sign_in.dart';
import 'package:myair/widget/background_painter.dart';
import 'package:myair/widget/content_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:myair/widget/logged_in_widget.dart';
import 'package:myair/widget/sign_up_widget.dart';
import 'package:provider/provider.dart';

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
            return LoggedInWidget();
          } else {
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
      CustomPaint(painter: BackgroundPainter()),
      Center(child: CircularProgressIndicator()),
    ],
  );
}
