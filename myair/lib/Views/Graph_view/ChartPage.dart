

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Widgets/ChartPage_widgets/ChartCardWidget.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/PieChart.dart';

import '../../main.dart';

class ChartPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    DailyUnitData dd = DailyUnitData();
   return Scaffold(
     backgroundColor: Theme.of(context).brightness == Brightness.light ? Color.fromRGBO(193, 214, 233, 1) :  Color(0xFF212121),
     body: SafeArea(
       child:ListView(
         children: <Widget> [ for(var index = 0; index < kInfo.value.length; index++)
           ChartCardWidget(index:index,)
         ],

       ),
       )
     );
  }

}
/*ListView.separated(
itemCount: kInfo.length,
itemBuilder:(_,index) => //TODO use average
ChartCardWidget(index:index),
separatorBuilder: (context, index) => Divider( ),
),*/