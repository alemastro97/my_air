
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Widgets/ChartPage_widgets/AnimatedChart.dart';
import 'package:myair/Widgets/ChartPage_widgets/ChartCardWidget.dart';
import 'package:myair/Widgets/ChartPage_widgets/ScrollableTabBar.dart';

import '../../main.dart';

class ChartPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   // DailyUnitData dd = DailyUnitData();
   return Scaffold(
     backgroundColor: Theme.of(context).brightness == Brightness.light ? Color.fromRGBO(193, 214, 233, 1) :  Color(0xFF212121),
     body: SafeArea(
       child:Padding(
         padding: const EdgeInsets.all(8.0),
         child: ListView(

           children: <Widget> [
             AnimatedChart(),
             SizedBox(height: MediaQuery.of(context).size.height/40,),
           Text(
             "Overview of your day",
             style: TextStyle(
               // color: LightColors.kDarkBlue,
                 fontSize: 20.0,
                 fontWeight: FontWeight.w700,
                 letterSpacing: 1.2),
           ),

             ScrollableTabBar(),
             SizedBox(height: MediaQuery.of(context).size.height/20,),
           ],

         ),
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