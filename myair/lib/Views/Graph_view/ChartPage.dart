
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Widgets/ChartPage_widgets/AnimatedChart.dart';
import 'package:intl/intl.dart';
import 'package:myair/Widgets/ChartPage_widgets/ScrollableTabBar.dart';

import '../../main.dart';

class ChartPage extends StatelessWidget{
  List<Pollution> hoursSorter = [];
  @override
  Widget build(BuildContext context) {
    _generateDate();
    print("----------------"+hoursSorter.length.toString());
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

             ScrollableTabBar(hourSorted: hoursSorter,),
             SizedBox(height: MediaQuery.of(context).size.height/20,),
           ],

         ),
       ),
       )
     );
  }

  _generateDate(){
      var date = new DateTime.now();
      for(var i = date.hour + 1; i < 24; i++){
        hoursSorter.add(new Pollution(DateFormat('MM-dd  kk:00').format(date.subtract(Duration(hours:  date.hour + (24 - i)))), 0.0, Colors.teal));
      }
      for(var i = 0; i <= date.hour; i++){
        hoursSorter.add(new Pollution(DateFormat('MM-dd  kk:00').format(date.subtract(Duration(hours: date.hour - i))), 0.0, Colors.teal));
      }
  }
}

class Pollution {
  Pollution( this.hour, this.value,this.color);
   String hour;
   double value;
   Color color;
}