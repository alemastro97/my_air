import 'package:myair/Widgets/Account_page_widgets/profile_screen_widget.dart';
import 'package:myair/Widgets/content_list_widget.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  var changeTopImage;



  SettingsPage({ Key key, this.changeTopImage,}) : super (key: key);

  @override
  Widget build(BuildContext context) => Scaffold(

    body: ProfileScreen(changeTopImage: changeTopImage),
  );
}
