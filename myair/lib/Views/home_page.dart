import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myair/Views/profile_page.dart';
import 'package:myair/Views/Graph_view/bar_charts_view.dart';
import 'package:myair/Views/settings_page.dart';
import 'package:myair/Services/Google_Service/google_sign_in.dart';
import 'package:myair/Widgets/Login_with_google/background_painter.dart';
import 'package:myair/Widgets/Login_with_google/logged_in_widget.dart';
import 'package:myair/Widgets/Login_with_google/sign_up_widget.dart';
import 'package:myair/Widgets/tabbar_material_widget.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'Reward_page/Reward_view.dart';
import 'map_page.dart';
import 'home_statistics_page.dart';


class HomePage extends StatefulWidget {
  final String title;

  const HomePage({
    @required this.title,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 4;

  final pages = <Widget>[
    ChartPreview(),
    EmailPage(),
    RewardView(),
    SettingsPage(),
    HomeStatisticsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return  ThemeSwitchingArea(child: Builder(
        builder: (context) {
          return Scaffold(
            extendBody: true,
            body: pages[index],
            appBar: AppBar(
              title: Text("MyAir"),
              automaticallyImplyLeading: false,
              actions:[Padding(
                padding: const EdgeInsets.all(8.0),
                child:top_image != null ? CircleAvatar(backgroundImage:   new FileImage(top_image)) : CircleAvatar(backgroundImage: new AssetImage('assets/images/blank_profile.png'), ),
              ),]
            ),
            bottomNavigationBar: TabBarMaterialWidget(
              index: index,
              onChangedTab: onChangedTab,
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.home_outlined),
              onPressed: () => onChangedTab(4),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
          );
        },
      ));

}
  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }
  //TODO insert a class that makes all of the image gestior

}

/*class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  int index = 0;
  final pages = <Widget>[
    SearchPage(),
    EmailPage(),
    ProfilePage(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    extendBody: true,
    body: pages[index],
    bottomNavigationBar: TabBarMaterialWidget(
      index: index,
      onChangedTab: onChangedTab,
    ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => print('Hello World'),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  );
  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }
}
*/