import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bordered_text/bordered_text.dart';

//Logo of the application used in registration and login pages
class LogoImport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        child: Stack(
          //Stack widget withe the logo of app and the name overlying
          children: [
            Center(
              child: FractionallySizedBox(
                heightFactor: 2 / 3,
                widthFactor: 2 / 3,
                child: Image(image: AssetImage('assets/images/app_icon.png')),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: 1 / 3,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: BorderedText(
                    strokeWidth: 1.0,
                    strokeColor: Colors.black,
                    child: Text(
                      'MyAir',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        decorationColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
