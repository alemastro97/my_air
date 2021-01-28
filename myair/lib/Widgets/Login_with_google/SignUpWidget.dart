import 'package:flutter/material.dart';

import 'package:bordered_text/bordered_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:myair/Views/login_view/LoginPage.dart';
import 'package:myair/Views/registration_page/RegistrationPage.dart';
import 'package:myair/Widgets/Login_with_google/GoogleSignupButtonWidget.dart';

class SignUpWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Stack(
      fit: StackFit.expand,
      children: [

        Container( //Definition of a container in order to set up a background
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Spacer(),
              //Title of the page
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: 175,
                  child: BorderedText(
                    strokeWidth: 1.0,
                    strokeColor: Colors.black,
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
              ),
              Spacer(),

              //Definition of the google sign in
              GoogleSignupButtonWidget(),

              //Sign up button, when it is pushed send you in the registration page
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                padding: EdgeInsets.all(4),
                child: OutlineButton.icon(
                  label: Text(
                    'Sign Up',
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
                      MaterialPageRoute(
                          builder: (context) => RegistrationPage()),
                    );
                  },
                ),
              ),

              //TextButton in case the user is already registered
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: TextButton(
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: <TextSpan>[
                              new TextSpan(
                                  text: 'Are you already registered? Go to the '),
                              new TextSpan(
                                  text: 'Login',
                                  style: new TextStyle(color: Colors.blue)),
                            ]),
                      ),
                      onPressed: () {//Send to the Login page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      }),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

