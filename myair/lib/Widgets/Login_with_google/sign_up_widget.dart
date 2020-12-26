
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myair/Views/login_view/login_view.dart';
import 'package:myair/Views/registration_page/registration_view.dart';
import 'package:myair/Widgets/Login_with_google/background_painter.dart';
import 'package:myair/Widgets/Login_with_google/google_signup_button_widget.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Stack(
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

        child: Column(
          children: [
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: 175,
                child: Text(
                  'Welcome Back To MyAir',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Spacer(),
            GoogleSignupButtonWidget(),
            Container(
              width: MediaQuery.of(context).size.width/2,
              padding: EdgeInsets.all(4),
              child: OutlineButton.icon(
                label: Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                highlightedBorderColor: Colors.black,
                borderSide: BorderSide(color: Colors.black),
                textColor: Colors.black,
                icon: FaIcon(FontAwesomeIcons.user, color: Colors.red),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ),
            Spacer(),
            SizedBox(height: 12),
            TextButton(
              child: Text(
                'Not registered yet?',
                style: TextStyle(fontSize: 16),
              ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage()),
                  );
                }
            ),
            Spacer(),
          ],
        ),
      ),
    ],
  );

}
TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);