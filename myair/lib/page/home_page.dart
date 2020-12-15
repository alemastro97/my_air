import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myair/page/profile_page.dart';
import 'package:myair/page/search_page.dart';
import 'package:myair/page/settings_page.dart';
import 'package:myair/provider/google_sign_in.dart';
import 'package:myair/widget/background_painter.dart';
import 'package:myair/widget/logged_in_widget.dart';
import 'package:myair/widget/sign_up_widget.dart';
import 'package:myair/widget/tabbar_material_widget.dart';
import 'package:provider/provider.dart';

import 'email_page.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({
    @required this.title,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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