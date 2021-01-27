import 'package:flutter/material.dart';
import 'package:myair/Widgets/Map_page_widgets/MapPageWidget.dart';

class MapPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
    body:Stack(
      children: <Widget>[
        new MapPageWidget(),
      ],
    ),
  );

}
