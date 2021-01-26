import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myair/Constants/pollution_graph_constants.dart';
import 'package:myair/Services/Database_service/DatabaseHelper.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:myair/Widgets/Settings_page_widgets/NameChanger.dart';
import 'package:myair/Widgets/Settings_page_widgets/PasswordChanger.dart';

import 'package:myair/main.dart';

import 'package:myair/Widgets/Settings_page_widgets/SliderAgent.dart';

class SettingsPageWidget extends StatefulWidget{
  @override
  _SettingsPageWidgetState createState() => _SettingsPageWidgetState();
}

class _SettingsPageWidgetState extends State<SettingsPageWidget>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Theme
          .of(context)
          .brightness == Brightness.light
          ? Color.fromRGBO(193, 214, 233, 1)
          : Color(0xFF212121),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme
              .of(context)
              .iconTheme
              .color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Settings"),
        actions: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(LineAwesomeIcons.cog),
        ),
        ],
        centerTitle: true,
      ),

      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[

          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                NameChanger(),
                const SizedBox(height: 10.0),

                PasswordChanger(),
                const SizedBox(height: 20.0),

                //Section Title
                Text(
                  "Notification Settings",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Theme
                        .of(context)
                        .brightness == Brightness.light ? Colors.indigo : Theme
                        .of(context)
                        .accentColor,
                  ),
                ),

                //Switch Received notification
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SwitchListTile(
                      activeColor: Theme
                          .of(context)
                          .brightness == Brightness.light
                          ? Color(0xFF6488E4)
                          : Theme
                          .of(context)
                          .accentColor,
                      contentPadding: const EdgeInsets.all(0),
                      value: actualUser.notificationSend,
                      title: Text("Received notification"),
                      onChanged: (val) {
                        setState(() {
                          actualUser.notificationSend = val;
                          actualUser.updateUser();
                        });
                      },
                    ),
                    Text(
                      "Push notification that you received in case you are entering a polluted area",
                      style: TextStyle(
                        //fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                //Sliders related to the notification limits
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    for(var index = 0; index <
                        actualUser.notificationLimits.length; index++ )
                      SliderAgent(max: Limits.elementAt(index),
                        index: index,
                        change: actualUser.notificationSend,),
                  ],
                ),

                //Switch related to the notifications about the reward
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SwitchListTile(
                      activeColor: Theme
                          .of(context)
                          .brightness == Brightness.light
                          ? Color(0xFF6488E4)
                          : Theme
                          .of(context)
                          .accentColor,
                      contentPadding: const EdgeInsets.all(0),
                      value: actualUser.notificationReward,
                      title: Text("Received reward's notification "),
                      onChanged: (val) {
                        setState(() {
                          actualUser.notificationReward = val;
                          actualUser.updateUser();
                        });
                      },
                    ),
                    Text(
                      "Push notification received if you complete a challenge",
                      style: TextStyle(
                        //fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),


                const SizedBox(height: 60.0),
              ],
            ),
          ),


          ///Used only for saving data for PRESENTATION PURPOSES
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 00,
            left: 00,
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.powerOff,
                color: Colors.white,
              ),
              onPressed: () async {
                await DatabaseHelper().insertDailyData();
                print("Close app");
              },
            ),
          )
        ],
      ),

    );
  }
}



