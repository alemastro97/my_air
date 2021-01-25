
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myair/Constants/theme_constants.dart';
import 'package:myair/Widgets/Account_page_widgets/ChangeImage.dart';
import 'package:myair/Widgets/Account_page_widgets/ProfileListItem.dart';
import 'package:myair/main.dart';

class UserPageWidget extends StatefulWidget{

  @override
  _UserPageWidgetState createState() => _UserPageWidgetState();

}
class _UserPageWidgetState extends State<UserPageWidget>{

  //Constant data used to auto generate buttons with a loop
  List<IconData> icons = [LineAwesomeIcons.cog,LineAwesomeIcons.question_circle,LineAwesomeIcons.alternate_sign_out];
  List<String> buttonNames = ['Settings', 'Help & Support', 'Logout'];

  @override
  Widget build(BuildContext context){

    //Widget where there are the image and the personal data (if you are watching the app are all the things up the divider)
    var profileInfo = Column(
      children:[
        //ImageWidget that include the image of the user and the function to change it
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChangeImage(),
          ),
        ),
        //List of two element with the personal data and the email
        Expanded(
          flex:2,
          child: Column(
            children: <Widget>[
              //Personal data
              Expanded(flex: 1,child: FractionallySizedBox(widthFactor: 0.7,child:FittedBox(fit: BoxFit.contain,child: Text(actualUser.firstName + " " + actualUser.lastName , style: kTitleTextStyle)),),),
              //Email
              Expanded(flex: 1,child: FractionallySizedBox(widthFactor: 0.7,child: FittedBox(fit: BoxFit.contain,child: Text(actualUser.email.toString(), style: kCaptionTextStyle)),),),
            ],
          ),
        ),
      ],
    );

    //This is the theme switcher -> the icon in the top right part that is used to change the theme of the application
    var themeSwitcher = ThemeSwitcher(builder: (context){
          return AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState:
            ThemeProvider.of(context).brightness == Brightness.dark
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: GestureDetector(
              onTap: () =>
                  ThemeSwitcher.of(context).changeTheme(theme: kLightTheme),
              child: Icon(
                LineAwesomeIcons.sun,
              ),
            ),
            secondChild: GestureDetector(
              onTap: () =>
                  ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme),
              child: Icon(
                LineAwesomeIcons.moon,
              ),
            ),
          );
    });

    //All the widget before the divider
    var header = Padding(
        padding: const EdgeInsets.all(8.0),
        child:Stack(
      children: <Widget>[
        profileInfo,
        Align(alignment: Alignment.topRight,child: themeSwitcher),
      ],
    ));

    return Scaffold(
      //Profile Info
      body: Column(
        children: <Widget>[
          //Personal info, image and switcher of the themes
          Expanded(flex: 4, child: header),
          Padding( //Divider
            padding: const EdgeInsets.all(8.0),
            child: Divider(color: Theme.of(context).dividerColor),
          ),
          //Buttons to go in settings, help & support pages or to do the logout
          Expanded(
            flex: 7,
            child: Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
              child: Column(
                children: <Widget>[
                  //Button generation
                  for(var index = 0; index < icons.length; index++)
                  Expanded(
                    flex: 2,
                    child: ProfileListItem(
                      icon: icons.elementAt(index),
                      text: buttonNames.elementAt(index),
                    ),
                  ),
                  Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
