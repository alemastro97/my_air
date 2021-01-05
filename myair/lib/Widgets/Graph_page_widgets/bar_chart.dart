

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
class barChart extends StatelessWidget{
 // var chartData;
  final data;

  const barChart({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // _generateData();
    return  SafeArea(
      child: Container(
        child: SfChartTheme(
          data: SfChartThemeData(

          ),
          child: SfCartesianChart(
              plotAreaBorderColor: Colors.transparent,
             // borderColor: Colors.red,
      //        borderWidth: 2,
              // Sets 15 logical pixels as margin for all the 4 sides.
            //  margin: EdgeInsets.all(15),
              enableAxisAnimation: true,
              primaryXAxis: NumericAxis(
                // Additional range padding is applied to y axis
                //rangePadding: ChartRangePadding.round,
                  minimum: 0,
                  maximum: 25,
                  interval: 4,
                  plotOffset: 0
              ),

              series: <ChartSeries>[
                ColumnSeries<Pollution, int>(
                    dataSource: [

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
                    ],
                    xValueMapper: (Pollution sales, _) => sales.place,
                    yValueMapper: (Pollution sales, _) => sales.quantity,
                    pointColorMapper: (Pollution data, _) => data.color
                )
              ]
          ),
        ),
      ),
    );
  }

}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Pollution {
  Pollution( this.place, this.quantity,this.color);
  final int place;
  final double quantity;
  final Color color;
}
