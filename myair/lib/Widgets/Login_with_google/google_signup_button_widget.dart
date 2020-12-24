import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myair/Services/Google_Service/google_sign_in.dart';
import 'package:provider/provider.dart';
/*Button of google login in the login page*/
class GoogleSignupButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    width: MediaQuery.of(context).size.width/2,
    padding: EdgeInsets.all(4),
    child: OutlineButton.icon(
      label: Flexible(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            'Sign In With Google',
            style: TextStyle(fontWeight: FontWeight.bold,),
          ),
        ),
      ),
      shape: StadiumBorder(),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      highlightedBorderColor: Colors.black,
      borderSide: BorderSide(color: Colors.black),
      textColor: Colors.black,
      icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
      onPressed: () {
        final provider =
        Provider.of<GoogleSignInProvider>(context, listen: false);
        provider.login();
      },
    ),
  );
}