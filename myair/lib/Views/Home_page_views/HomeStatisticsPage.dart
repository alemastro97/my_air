import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/GraphWidget.dart';

class HomeStatisticsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GraphWidget(),
    );
  }
}
