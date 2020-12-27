

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Widgets/Graph_page_widgets/Preview_chart_widget.dart';

class ChartPreview extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: SafeArea(
       child:ListView(
         children: [
           ///Remember to use for cycle
           ChartCardWidget(element: "PM10",),
         ],
       )
     ),
   );
  }

}
