
import 'package:flutter/cupertino.dart';
import 'package:myair/Widgets/Settings_page_widgets/SettingsPageWidget.dart';

class SettingsPage extends StatelessWidget{
  final setname;

  const SettingsPage({Key key, this.setname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsPageWidget(setname: setname);
  }
}

