
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'active_project_card.dart';

class RewardScaffold extends StatelessWidget{
  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
         // color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
          horizontal: 20.0, vertical: 10.0),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              subheading('Daily Achievements'),
              SizedBox(height: 5.0),
              Column(
                children: [
                  Row(
                    children: <Widget>[


                      ActiveProjectsCard(
                        cardColor: Color(0xFF6488E4),
                        loadingPercent: 0.9,
                        title: 'Online Flutter Course',
                        subtitle: '23 hours progress',
                      ),
                    ],
                  ),
                ],
              ),
              subheading('Weekly achievements'),
              SizedBox(height: 5.0),
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      ActiveProjectsCard(
                        cardColor: Color(0xFF309397),
                        loadingPercent: 0.25,
                        title: 'Daily Access',
                        subtitle: 'Log in for 7 days in a row',
                      ),
                      SizedBox(width: 20.0),
                      ActiveProjectsCard(
                        cardColor: Color(0xFFE46472),
                        loadingPercent: 0.6,
                        title: 'My air is better',
                        subtitle: 'Breathe in clean air for a total of 100 hours',
                      ),
                      SizedBox(width: 20.0),
                      ActiveProjectsCard(
                        cardColor: Color(0xFFF9BE7C),
                        loadingPercent: 0.45,
                        title: 'Don\'t touch the bottom',
                        subtitle: 'Never enter highly polluted areas',
                      ),
                    ],
                  ), ///Weekly achievements
                  ]),


              Row(
                    children: <Widget>[
                      ActiveProjectsCard(
                        cardColor: Color(0xFF309397),
                        loadingPercent: 0.25,
                        title: 'Medical App',
                        subtitle: '9 hours progress',
                      ),
                      SizedBox(width: 20.0),
                      ActiveProjectsCard(
                        cardColor: Color(0xFFE46472),
                        loadingPercent: 0.6,
                        title: 'Making History Notes',
                        subtitle: '20 hours progress',
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      ActiveProjectsCard(
                        cardColor:  Color(0xFFF9BE7C),
                        loadingPercent: 0.45,
                        title: 'Sports App',
                        subtitle: '5 hours progress',
                      ),
                      SizedBox(width: 20.0),
                      ActiveProjectsCard(
                        cardColor: Color(0xFF6488E4),
                        loadingPercent: 0.9,
                        title: 'Online Flutter Course',
                        subtitle: '23 hours progress',
                      ),
                    ],
                  ),


                ],
              ),
              ],
          ),

    );
  }

}