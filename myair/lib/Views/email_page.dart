import 'package:myair/Widgets/content_list_widget.dart';
import 'package:flutter/material.dart';

import '../Widgets/Map_page_widgets/map_widget.dart';

class EmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Our Stations'),
    ),
    body:Stack(
      children: <Widget>[
        new MapWidget(),
      ],
    ),
  );
}
