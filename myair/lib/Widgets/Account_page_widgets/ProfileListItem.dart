
import 'package:flutter/cupertino.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myair/Constants/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myair/Services/Database_service/DatabaseHelper.dart';
import 'package:myair/Services/Google_Service/GoogleSignIn.dart';
import 'package:myair/Views/Help&Support_view/HelpSupportPage.dart';
import 'package:myair/Views/Privacy_view/PrivacyView.dart';
import 'package:myair/Views/Settings_view/SettingsPage.dart';
import 'package:provider/provider.dart';


class ProfileListItem  extends StatelessWidget{
  final IconData icon;
  final text;
  final bool hasNavigation;
  final Function setName;
  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = true, this.setName
  }) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10.0,horizontal:40.0),
      child: GestureDetector(
        onTap: (){
          switch(text){
            case 'Logout':{
              final provider =
              GoogleSignInProvider().logout();
              DatabaseHelper().deleteUser();
              Navigator.pushReplacementNamed(context, '/Login');
            }
            break;
            case 'Privacy':{Navigator.of(context).push(createRoute(privacyView()));}
            break;
            case 'Help & Support':{Navigator.of(context).push(createRoute(HelpSupportView()));}
            break;
            case 'Settings' : {Navigator.of(context).push(createRoute(SettingsPage(setname: setName)));}
            break;//SettingsView
            default:{}
          }
        },
        child: Container(

        //  margin: EdgeInsets.symmetric( ).copyWith(),
         // padding: EdgeInsets.symmetric( ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 3),
            color: Theme.of(context).backgroundColor,
          ),
          child: Row(
            children: <Widget>[
            //  Icon(this.icon,),

              //Text(this.text,style: kTitleTextStyle.copyWith(fontWeight: FontWeight.w500),),
              Expanded(flex: 2,child:  Icon(this.icon,),),
              Expanded(flex: 7,child:Center(
                  child: FractionallySizedBox(
                    heightFactor:0.4,
                    child: FittedBox(fit: BoxFit.fitHeight,child: Text(this.text,style: kTitleTextStyle.copyWith(fontWeight: FontWeight.w500),), ),))),

              Expanded(
                flex: 1,

                child:Icon(
                  LineAwesomeIcons.angle_right,
                ),)

            ],
          ),
        ),
      ),
    );
  }
//todo create a router class
  Route createRoute(Widget endPage) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => endPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}