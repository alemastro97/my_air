

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
class BarChart extends StatelessWidget{
 // var chartData;
  final List<double> data;
  
  BarChart({Key key, this.data}) : super(key: key);
  
  List<Pollution> dataSource = [];
  @override
  Widget build(BuildContext context) {
    final List<Color> color = <Color>[];
    color.add(Colors.blue[50]);
    color.add(Colors.blue[200]);
    color.add(Colors.blue);

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    final LinearGradient gradientColors =
    LinearGradient(colors: color, stops: stops);
    _generateData();
    return  SafeArea(
      child: Container(
        child: SfChartTheme(
          data: SfChartThemeData(
          ),
          child:SfCartesianChart(
              plotAreaBorderColor: Colors.transparent,
              enableAxisAnimation: true,
              primaryXAxis:CategoryAxis(interval: 6,) ,
              //  primaryXAxis: NumericAxis(
              //            minimum: 0,
              //            maximum: 25,
              //            interval: 4,
              //            plotOffset: 0
               //   ),

              series: <ChartSeries>[
                ColumnSeries<Pollution, String>(
                    dataSource: dataSource,
                    xValueMapper: (Pollution p, _) => p.hour,
                    yValueMapper: (Pollution p, _) => p.value,
                    pointColorMapper: (Pollution data, _) => data.color
                  /* dataSource: dataSource,
                    xValueMapper: (Pollution p, _) => p.hour,
                    yValueMapper: (Pollution p, _) => p.value,
                    pointColorMapper: (Pollution data, _) => data.color*/
                )
              ]
          ),

          /* SfCartesianChart(
            primaryXAxis:CategoryAxis(interval: 5,) ,
              series: <ChartSeries>[
                LineSeries<Pollution, String>(
                    dataSource: dataSource,
                    xValueMapper: (Pollution p, _) => p.hour,
                    yValueMapper: (Pollution p, _) => p.value,
                    //gradient: gradientColors,
                )
              ]
          )*/
        ),
      ),
    );
  }

  _generateData (){
   // int duration = 0;
    var date = new DateTime.now();
    //var hour = date.hour;
print( DateFormat('MM-dd  kk:00').format(   DateTime.now().subtract(Duration(hours: 24))));
    for(var i = 0; i < data.length; i++){
      print(i.toString() +" "+data.elementAt(i).toString());

    }
    for(var i = date.hour + 1; i < data.length; i++){
        print(i.toString() + "   " +  DateFormat('MM-dd  kk:00').format(date.subtract(Duration(hours:  date.hour + (24 - i)))) +" "+data.elementAt(date.hour + (24 - i)).toString());
        dataSource.add(new Pollution(DateFormat('MM-dd  kk:00').format(date.subtract(Duration(hours:  date.hour + (24 - i)))), data.elementAt(date.hour + (24 - i)), Colors.teal));
    }
    print("xxxx");
    for(var i = 0; i <= date.hour; i++){

      print(i.toString() + "   " + DateFormat('MM-dd  kk:00').format(date.subtract(Duration(hours:date.hour - i))) +" "+data.elementAt(i).toString());
        dataSource.add(new Pollution(DateFormat('MM-dd  kk:00').format(date.subtract(Duration(hours: date.hour - i))), data.elementAt(i), Colors.teal));
    }
    print("------------------------------------------------------------------------------");
    for(var i =  0; i < dataSource.length; i++){
      //print(DateFormat('MM-dd  kk:00').format(date.subtract(Duration(hours:  date.hour + (24 - i)))) +" "+data.elementAt(i).toString());
      print( dataSource.elementAt(i).value.toString());

    }

  }
}
class Pollution {
  Pollution( this.hour, this.value,this.color);
  final String hour;
  final double value;
  final Color color;
}
/*
class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}


 [
                      Pollution(01, 30,Colors.teal),
                      Pollution(02, 40,Colors.orange),
                      Pollution(03, 10,Colors.brown),
                      Pollution(04, 30,Colors.teal),
                      Pollution(05, 40,Colors.orange),
                      Pollution(06, 10,Colors.brown),
                      Pollution(07, 30,Colors.teal),
                      Pollution(08, 40,Colors.orange),
                      Pollution(09, 10,Colors.brown),
                      Pollution(10, 30,Colors.teal),
                      Pollution(11, 40,Colors.orange),
                      Pollution(12, 10,Colors.brown),
                      Pollution(13, 30,Colors.teal),
                      Pollution(14, 40,Colors.orange),
                      Pollution(15, 10,Colors.brown),
                      Pollution(16, 30,Colors.teal),
                      Pollution(17, 40,Colors.orange),
                      Pollution(18, 10,Colors.brown),
                      Pollution(19, 30,Colors.teal),
                      Pollution(20, 40,Colors.orange),
                      Pollution(21, 10,Colors.brown),
                      Pollution(22, 30,Colors.teal),
                      Pollution(23, 40,Colors.orange),
                      Pollution(24, 10,Colors.brown),
                    ]*/