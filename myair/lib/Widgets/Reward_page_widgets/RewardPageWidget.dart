
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:myair/main.dart';
import 'package:myair/Modules/PollutantAgent.dart';
import 'package:myair/Widgets/Reward_page_widgets/ActiveReward.dart';

class RewardPageWidget extends StatelessWidget{
//Definition of the subheading widgeta
  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
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
          horizontal: 20.0, vertical: 10.0
      ),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          //All the page rewards
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              //Title of the page
              subheading('Quality Air Achievements'),

              //Description of the daily rewards
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "These rewards are calculated based on how long you will be in clean areas. The longer you stay the more points you will earn",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              //Reward generation based on a static list
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      ActiveReward(
                        cardColor: Color(0xFF6488E4),
                        loadingPercent: PollutantAgent().get_pm10_rw()/PollutantAgent().get_pm10_limit(),
                        title: 'PM10',
                        subtitle:  ' ',
                      ),
                      SizedBox(width: 20.0),
                      ActiveReward(
                        cardColor: Color(0xFF6488E4),
                        loadingPercent:  PollutantAgent().get_pm25_rw()/PollutantAgent().get_pm25_limit(),
                        title: 'PM2.5',
                        subtitle: ' ',
                      ),
                    ],
                  ), Row(
                    children: <Widget>[
                      ActiveReward(
                        cardColor: Color(0xFF6488E4),
                        loadingPercent:  PollutantAgent().get_no2_rw()/PollutantAgent().get_no2_limit(),
                        title: 'NO2',
                        subtitle: ' ',
                      ),
                      SizedBox(width: 20.0),
                      ActiveReward(
                        cardColor: Color(0xFF6488E4),
                        loadingPercent:  PollutantAgent().get_so2_rw()/PollutantAgent().get_so2_limit(),
                        title: 'SO2',
                        subtitle: ' ',
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      ActiveReward(
                        cardColor: Color(0xFF6488E4),
                        loadingPercent: PollutantAgent().get_o3_rw()/PollutantAgent().get_o3_limit(),
                        title: 'O3',
                        subtitle: ' ',
                      ),
                      SizedBox(width: 20.0),
                      ActiveReward(
                        cardColor: Color(0xFF6488E4),
                        loadingPercent: PollutantAgent().get_co_rw()/PollutantAgent().get_co_limit(),
                        title: 'CO',
                        subtitle: ' ',
                      ),
                    ],
                  ),
                ],
              ),

              //Weekly Achivments
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