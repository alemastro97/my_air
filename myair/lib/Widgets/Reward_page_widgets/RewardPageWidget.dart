
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:myair/Modules/PollutantAgent.dart';
import 'package:myair/main.dart';

import 'ActiveReward.dart';

class RewardPageWidget extends StatelessWidget{

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
    //DailyUnitData d = DailyUnitData();
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
              subheading('Quality Air Achievements'),
              SizedBox(height: 5.0),
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      ActiveReward(
                        cardColor: Color(0xFF6488E4),
                        loadingPercent: PollutantAgent().get_pm10_rw()/PollutantAgent().get_pm10_limit(),
                        title: 'PM10',
                        subtitle: 'reward calculation',
                      ),
                      SizedBox(width: 20.0),
                      ActiveReward(
                        cardColor: Color(0xFF6488E4),
                        loadingPercent:  PollutantAgent().get_pm25_rw()/PollutantAgent().get_pm25_limit(),
                        title: 'PM2.5',
                        subtitle: 'reward calculation',
                      ),
                    ],
                  ), Row(
                    children: <Widget>[
                      //    Text(PollutantAgent().get_pm10_rw().toString()),

                      ActiveReward(
                        cardColor: Color(0xFF6488E4),
                        loadingPercent:  PollutantAgent().get_no2_rw()/PollutantAgent().get_no2_limit(),
                        title: 'NO2',
                        subtitle: 'reward calculation',
                      ),
                      SizedBox(width: 20.0),
                      ActiveReward(
                        cardColor: Color(0xFF6488E4),
                        loadingPercent:  PollutantAgent().get_so2_rw()/PollutantAgent().get_so2_limit(),
                        title: 'SO2',
                        subtitle: 'reward calculation',
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      //    Text(PollutantAgent().get_pm10_rw().toString()),

                      ActiveReward(
                        cardColor: Color(0xFF6488E4),
                        loadingPercent: PollutantAgent().get_o3_rw()/PollutantAgent().get_o3_limit(),
                        title: 'O3',
                        subtitle: 'reward calculation',
                      ),
                      SizedBox(width: 20.0),
                      ActiveReward(
                        cardColor: Color(0xFF6488E4),
                        loadingPercent: PollutantAgent().get_co_rw()/PollutantAgent().get_co_limit(),
                        title: 'CO',
                        subtitle: 'reward calculation',
                      ),
                    ],
                  ),
                ],
              ),
              subheading('Weekly achievements'),
              SizedBox(height: 5.0),
              Row(
                children: [
                  ActiveReward(
                    cardColor: Color(0xFFE46472),
                    loadingPercent: actualUser.hourSafe / 3000,
                    title: 'My air is better',
                    subtitle: 'Breathe in clean air for a total of 100 hours',
                  ),
                ],
              ),
//              SizedBox(width: 20.0),
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      ActiveReward(
                        cardColor: Color(0xFF309397),
                        loadingPercent: actualUser.counter/7,
                        title: 'Daily Access',
                        subtitle: 'Log in for 7 days in a row',
                      ),
                      SizedBox(width: 20.0),
                      ActiveReward(
                        cardColor: Color(0xFFF9BE7C),
                        loadingPercent: actualUser.weeklyMissionFailed ? DateTime.now().weekday/7 : 0.0,
                        title: 'Don\'t touch the bottom',
                        subtitle: 'Never enter highly polluted areas',
                      ),
                    ],
                  ), ///Weekly achievements
                  ]),



                ],
              ),
              ],
          ),

    );
  }

}