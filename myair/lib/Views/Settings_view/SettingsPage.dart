
import 'package:flutter/cupertino.dart';
import 'package:myair/Widgets/Settings_page_widgets/SettingsPageWidget.dart';

class SettingsPage extends StatelessWidget{
  final Function setName;

  const SettingsPage({Key key, this.setName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsPageWidget(setName: setName);
  }
}

