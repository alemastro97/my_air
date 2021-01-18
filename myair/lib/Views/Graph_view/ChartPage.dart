
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Widgets/ChartPage_widgets/AnimatedChart.dart';
import 'package:myair/Widgets/ChartPage_widgets/ChartCardWidget.dart';

import '../../main.dart';

class ChartPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   // DailyUnitData dd = DailyUnitData();
   return Scaffold(
     backgroundColor: Theme.of(context).brightness == Brightness.light ? Color.fromRGBO(193, 214, 233, 1) :  Color(0xFF212121),
     body: SafeArea(
       child:ListView(

         children: <Widget> [
           AnimatedChart(),
           for(var index = 0; index < kInfo.value.length; index++)
           ChartCardWidget(
               index:index,
               data: index == 0 ? DailyUnitData().getPM10Values()
                   :
               index == 1 ? DailyUnitData().getPM25Values()
                   :
               index == 2 ? DailyUnitData().getNO2Values()
                   :
               index == 3 ? DailyUnitData().getSO2Values()
                   :
               index == 4 ? DailyUnitData().getO3Values()
                   :
               DailyUnitData().getCOValues()),
         ],

       ),
       )
     );
  }
//TODO inserire _generate data qui e dimezzare i lavori
}
/*ListView.separated(
itemCount: kInfo.length,
itemBuilder:(_,index) => //TODO use average
ChartCardWidget(index:index),
separatorBuilder: (context, index) => Divider( ),
),*/