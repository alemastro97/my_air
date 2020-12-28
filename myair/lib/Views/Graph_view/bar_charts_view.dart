

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Widgets/Graph_page_widgets/Preview_chart_widget.dart';

class ChartPreview extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Theme.of(context).brightness == Brightness.light ? Color.fromRGBO(193, 214, 233, 1) :  Color(0xFF212121),
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
