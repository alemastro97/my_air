
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'package:myair/main.dart';
import 'package:myair/Widgets/TabBarMaterialWidget.dart';
import 'package:myair/Views/AccountPage.dart';
import 'package:myair/Views/Graph_view/ChartPage.dart';
import 'package:myair/Views/Reward_page/RewardPage.dart';
import 'package:myair/Views/MapPage.dart';
import 'package:myair/Views/Home_page_views/HomeStatisticsPage.dart';

class HomePage extends StatefulWidget {

  @override
  HomePageState createState() => HomePageState();

}

class HomePageState extends State<HomePage> {

  int index = 4; //Index of the first page -> home page

  @override
  Widget build(BuildContext context) {

    //Static generation of the pages
    final pages = <Widget>[
      ChartPage(),
      MapPage(),
      RewardPage(),
      AccountPage(),
      HomeStatisticsPage(),
    ];

    //At the opening of the app
    actualUser.checkWeeklyChallenges();

    return  ThemeSwitchingArea(
      child: Scaffold(
            extendBody: true,
            body: pages[index],
            appBar: AppBar(
              title: Text("MyAir"),
              automaticallyImplyLeading: false,
           ),
            bottomNavigationBar: TabBarMaterialWidget(
              onChangedTab: onChangedTab,
              index: index,
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.home_outlined),
              onPressed: () => onChangedTab(4),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
          ),
  );
}

//Set state to change the page selected by the user
  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }

}