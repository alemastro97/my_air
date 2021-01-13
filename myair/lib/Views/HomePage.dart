import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:myair/Views/Graph_view/ChartPage.dart';
import 'package:myair/Views/UserPage.dart';

import 'package:myair/Widgets/TabBarMaterialWidget.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io' as Io;
import '../main.dart';
import 'Reward_page/RewardPage.dart';
import 'MapPage.dart';
import 'Home_page_views/HomeStatisticsPage.dart';
import 'package:path/path.dart' as path;

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({
    @required this.title,
  });

  @override
  HomePageState createState() => HomePageState();

}

class HomePageState extends State<HomePage> {
  int index = 4;
  Io.File top_image = null;


  @override
  Widget build(BuildContext context) {
    //actualUser.checkWeeklyChallenges();
    final pages = <Widget>[
      ChartPage(),
      MapPage(),
      RewardPage(),
      UserPage(changeTopImage: changeTopImage),
      HomeStatisticsPage(),
    ];
    return  ThemeSwitchingArea(child: FutureBuilder(
      future: changeTopImage(),
      builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        actualUser.checkWeeklyChallenges();
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
  Future<Io.File> writeImageTemp(String base64Image, String imageName) async {
    final dir = await getTemporaryDirectory();
    await dir.create(recursive: true);
    final tempFile = Io.File(path.join(dir.path, imageName));
    await tempFile.writeAsBytes(base64.decode(base64Image));
    return tempFile;
  }
  Future<void> changeTopImage() async {

  //  setState(() async {
      imageCache.clear();
      imageCache.clearLiveImages();
      top_image = await writeImageTemp(actualUser.img, 'image');
  //  });
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