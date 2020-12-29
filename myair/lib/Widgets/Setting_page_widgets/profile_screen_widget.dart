
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myair/Constants/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myair/Widgets/Setting_page_widgets/profile_list_item.dart';

class ProfileScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    var profileInfo = Column(
      children:[
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              child: Stack(
                children: [
                  Center(
                    child:  CircleAvatar(
                          radius: MediaQuery.of(context).size.height,
                          //backgroundImage: AssetImage(''),
                        ),
                    ),
                  Align(
                      alignment: Alignment.center,
                      child:Container(
                          width:( MediaQuery.of(context).size.height)/5,
                          height: MediaQuery.of(context).size.height/5,

                        child:Align(
                          alignment: Alignment.bottomRight,
                          child: FractionallySizedBox(
                            widthFactor: 0.3,
                            heightFactor:0.3,
                            child: Container(
                                child:  Container(
                                  // width:( MediaQuery.of(context).size.height)/10,
                                  decoration:
                                  BoxDecoration(color: Theme.of(context).accentColor,
                                      shape: BoxShape.circle
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Icon(
                                        LineAwesomeIcons.pen,
                                        color: kDarkPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                            ),
                          ),
                        ), /*Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                           // width:( MediaQuery.of(context).size.height)/10,
                            decoration:
                            BoxDecoration(color: Theme.of(context).accentColor,
                                shape: BoxShape.circle
                            ),
                            child: Placeholder(),
                          ),
                        )//////Icon(
                          LineAwesomeIcons.pen,
                          color: kDarkPrimaryColor,
                        ),*/
                      ),),

                ],
              ),



            ),
          ),
        ),
        Expanded(
          flex:2,
          child: Column(
            children: <Widget>[
              Expanded(flex: 1,child: FractionallySizedBox(widthFactor: 0.7,child:FittedBox(fit: BoxFit.contain,child: Text('Alessandro Mastropasqua', style: kTitleTextStyle)),),),
              Expanded(flex: 1,child: FractionallySizedBox(widthFactor: 0.7,child: FittedBox(fit: BoxFit.contain,child: Text('alessandro.mastropasqua@mail.polimi.it', style: kCaptionTextStyle)),),),
            ],
          ),
        ),
           // Expanded(flex: 1,child: Container(child: FittedBox(fit: BoxFit.contain,child: Text('Alessandro Mastropasqua', style: kTitleTextStyle)))),
           // Expanded(flex: 1,child: Container(child: FittedBox(fit: BoxFit.contain,child: Text('alessandro.mastropasqua@mail.polimi.it', style: kCaptionTextStyle),))),


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
        //    firstCurve: Curves.easeOut,
        //    secondCurve: Curves.easeIn,
        //    sizeCurve: Curves.bounceOut,
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


/*
* return AnimatedCrossFade(
            duration: Duration(milliseconds: 200),
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
*
* */