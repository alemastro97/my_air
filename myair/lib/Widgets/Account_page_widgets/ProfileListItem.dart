import 'package:flutter/cupertino.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myair/Constants/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:myair/Services/Database_service/DatabaseHelper.dart';
import 'package:myair/Services/Google_Service/GoogleSignIn.dart';
import 'package:myair/Views/Help&Support_view/HelpSupportPage.dart';
import 'package:myair/Views/Settings_view/SettingsPage.dart';

//Button of the Account page
class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final text;
  final Function setName; // Function used by the settings page to update the name of the user

  //Constructor
  const ProfileListItem({Key key, this.icon, this.text, this.setName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
      child: GestureDetector(
        onTap: () {
          switch (text) {
            //Logout button: delete the user from the database and its google account (if one is present)
            case 'Logout':
              {
                GoogleSignInProvider().logout();
                DatabaseHelper().deleteUser();
                Navigator.pushReplacementNamed(context, '/Login');
              }
              break;
            case 'Help & Support':
              {
                Navigator.of(context).push(createRoute(HelpSupportView()));
              }
              break;
            //Settings: possibility to change settings of the account as: name, password and limits for the notification
            case 'Settings':
              {
                Navigator.of(context)
                    .push(createRoute(SettingsPage()));
              }
              break;
            default:
              {}
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * 3),
            color: Theme.of(context).backgroundColor,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Icon(
                  this.icon,
                ),
              ),
              Expanded(
                  flex: 7,
                  child: Center(
                      child: FractionallySizedBox(
                    heightFactor: 0.4,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        this.text,
                        style: kTitleTextStyle.copyWith(
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ))),
              Expanded(
                flex: 1,
                child: Icon(
                  LineAwesomeIcons.angle_right,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//Used to create a go and back route for the page that is "created" when you click the button
  Route createRoute(Widget endPage) {
    //Creation of the animation switch between the account page to the Settings/Help&Support pages
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => endPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
