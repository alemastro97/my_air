
import 'package:flutter/cupertino.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myair/Constants/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ProfileListItem  extends StatelessWidget{
  final IconData icon;
  final text;
  final bool hasNavigation;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = true
  }) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10.0,horizontal:40.0),
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
            Expanded(flex: 7,child:Center(child: FractionallySizedBox(heightFactor:0.4, child: FittedBox(fit: BoxFit.fitHeight,child: Text(this.text,style: kTitleTextStyle.copyWith(fontWeight: FontWeight.w500),), ),))),

            Expanded(
              flex: 1,

              child:Icon(
                LineAwesomeIcons.angle_right,
              ),)

          ],
        ),
      ),
    );
  }

}