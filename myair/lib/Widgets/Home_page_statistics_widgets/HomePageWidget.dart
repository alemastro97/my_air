

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'GraphWidget.dart';

class HomePageWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        GraphWidget(),
      ],
    );
  }

}