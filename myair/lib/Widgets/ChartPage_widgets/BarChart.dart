

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
  /*  final List<Color> color = <Color>[];
    color.add(Colors.blue[50]);
    color.add(Colors.blue[200]);
    color.add(Colors.blue);

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    final LinearGradient gradientColors =
    LinearGradient(colors: color, stops: stops);*/
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
                    pointColorMapper: (Pollution data, _) => data.color,

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
    var date = new DateTime.now();
    for(var i = date.hour + 1; i < data.length; i++){
        dataSource.add(new Pollution(DateFormat('MM-dd  kk:00').format(date.subtract(Duration(hours:  date.hour + (24 - i)))), data.elementAt(date.hour + (24 - i)), Colors.teal));
    }
    for(var i = 0; i <= date.hour; i++){
        dataSource.add(new Pollution(DateFormat('MM-dd  kk:00').format(date.subtract(Duration(hours: date.hour - i))), data.elementAt(i), Colors.teal));
    }
  }
}
class Pollution {
  Pollution( this.hour, this.value,this.color);
  final String hour;
  final double value;
  final Color color;
}
