
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myair/Constants/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myair/Widgets/Account_page_widgets/ChangeImage.dart';
import 'package:myair/Widgets/Account_page_widgets/ProfileListItem.dart';
import 'package:myair/main.dart';

class UserPageWidget extends StatefulWidget{
  final Function  changeTopImage;
  UserPageWidget( {
    Key key,
    this.changeTopImage,
  }) : super (key: key);

  _UserPageWidgetState createState() => _UserPageWidgetState();
}
class _UserPageWidgetState extends State<UserPageWidget>{
  var first;
  var last;
  @override
  initState(){
    super.initState();
    first = actualUser.firstName;
    last =  actualUser.lastName;
  }
  changeUsername(){
    setState(() {
      first = actualUser.firstName;
      last =  actualUser.lastName;
    });
  }

  @override
  Widget build(BuildContext context){
    var profileInfo = Column(
      children:[
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChangeImage(changeTopImage: widget.changeTopImage),
          ),
        ),
        Expanded(
          flex:2,
          child: Column(
            children: <Widget>[
              Expanded(flex: 1,child: FractionallySizedBox(widthFactor: 0.7,child:FittedBox(fit: BoxFit.contain,child: Text(first + " " + last , style: kTitleTextStyle)),),),
              Expanded(flex: 1,child: FractionallySizedBox(widthFactor: 0.7,child: FittedBox(fit: BoxFit.contain,child: Text(actualUser.email.toString(), style: kCaptionTextStyle)),),),
            ],
          ),
        ),
      ],
    );
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
    var header = Padding(
        padding: const EdgeInsets.all(8.0),
        child:Stack(
      children: <Widget>[


        profileInfo,
        Align(alignment: Alignment.topRight,child: themeSwitcher),
      ],
    ));

        return  Scaffold(
          //Profile Info
          body: Column(
            children: <Widget>[

              Expanded(flex:4 ,child: header),
             Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                    color: Theme.of(context).dividerColor
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0,bottom: 90.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1 ,
                        child: ProfileListItem(
                          icon: LineAwesomeIcons.user_shield,
                          text: 'Privacy',
                        ),
                      ),
                      Expanded(
                        flex: 1 ,
                        child: ProfileListItem(
                          icon: LineAwesomeIcons.question_circle,
                          text: 'Help & Support',
                        ),
                      ),
                      Expanded(
                        flex: 1 ,
                        child: ProfileListItem(
                          icon: LineAwesomeIcons.cog,
                          text: 'Settings',
                          setName: changeUsername,
                        ),
                      ),
                      Expanded(
                        flex: 1 ,
                        child:   ProfileListItem(
                          icon: LineAwesomeIcons.alternate_sign_out,
                          text: 'Logout',
                          hasNavigation: false,
                        ),
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

