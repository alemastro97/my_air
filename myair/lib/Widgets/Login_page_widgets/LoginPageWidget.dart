

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Widgets/Login_page_widgets/LoginForm.dart';
import 'package:myair/Widgets/Opening_page_widgets/LogoWidget.dart';

class LoginPageWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container( //Used to set the background image
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only( //Setting of the padding
              left: MediaQuery.of(context).size.width / 10,
              right: MediaQuery.of(context).size.width / 10,
              bottom: MediaQuery.of(context).size.width / 4,
              top: MediaQuery.of(context).size.width / 4),
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / 20),
                ),
                color: Colors.transparent.withOpacity(0.5),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Logo of the application
                      LogoImport(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(),
                      ),
                      //Form for the login
                      LoginForm(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}