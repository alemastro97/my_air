
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Widgets/ChartPage_widgets/AnimatedChart.dart';
import 'package:intl/intl.dart';
import 'package:myair/Widgets/ChartPage_widgets/ScrollableTabBar.dart';

import '../../main.dart';

class ChartPage extends StatelessWidget{

  List<Pollution> hoursSorter = []; //List of hours sorted according to the current one to lighten the workload of the application

  @override
  Widget build(BuildContext context) {
    //Fill hoursSorter
    _generateDate();

   return Scaffold(

     backgroundColor: Theme.of(context).brightness == Brightness.light ? Color.fromRGBO(193, 214, 233, 1) :  Color(0xFF212121),

     body: SafeArea(
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: ListView(
           children: <Widget> [
             //Chart animated that shows the trend of the last 24h in an animated view
             AnimatedChart(),
             SizedBox(height: MediaQuery.of(context).size.height/40,),
            //Overview in bar chart form
           Text(
             "Overview of your day",
             style: TextStyle(
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

  //Function that generates the strings for the actual hour or the day before
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

//Support Class
class Pollution {
  Pollution( this.hour, this.value,this.color);
   String hour;
   double value;
   Color color;
}