import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
class barChartPreview extends StatelessWidget{
  var chartData;
  _generateData() {



    /*   _seriesData.add(
      charts.Series(

        domainFn: (Pollution pollution,_) => pollution.place,
        measureFn: (Pollution pollution,_) => pollution.quantity,

        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );*/

    /*  _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution,_) => pollution.place,
        measureFn: (Pollution pollution,_) => pollution.quantity,
        id: '2018',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff109618)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution,_) => pollution.place,
        measureFn: (Pollution pollution,_) => pollution.quantity,
        id: '2019',
        data: data3,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      ),
    );
*/
    /*var pieData=[
      new Task('Work', 35.8, Color(0xff3366cc)),
      new Task('Eat', 8.3, Color(0xff3366cc)),
      new Task('Commute', 10.8, Color(0xff3366cc)),
      new Task('TV', 15.6, Color(0xff3366cc)),
      new Task('Sleep', 19.2, Color(0xff3366cc)),
      new Task('Other', 10.3, Color(0xff3366cc)),
    ];

   _seriesPieData.add(
        charts.Series(
          data: pieData,
          domainFn: (Task task,_)=> task.task,
          measureFn: (Task task,_) => task.taskvalue,
          colorFn: (Task task,_) =>
              charts.ColorUtil.fromDartColor(task.colorval),
          id:'Daily Task',
          labelAccessorFn: (Task row,_) => '${row.taskvalue}',
        )
    );*/
  }

  @override
  Widget build(BuildContext context) {

    var barColor = Theme.of(context).brightness == Brightness.light ? Colors.blueAccent : Color(0xFFFFC107);
    // _generateData();
    return  SafeArea(
      child: Container(
       // color: Theme.of(context).brightness == Brightness.light ? Colors.white60 : Color(0xFF373737),
        child: SfChartTheme(
          data: SfChartThemeData(
            //  brightness: Theme.of(context).brightness,
         //     backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white60 : Color(0xFF373737)
          ),
          child: SfCartesianChart(
              plotAreaBorderColor: Colors.transparent,
          //  plotAreaBackgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white60 : Color(0xFF373737),
//            backgroundColor:  Theme.of(context).brightness == Brightness.light ? Colors.white60 : Color(0xFF373737),
            // borderColor: Colors.red,
            //        borderWidth: 2,
            // Sets 15 logical pixels as margin for all the 4 sides.
            //  margin: EdgeInsets.all(15),
              //enableAxisAnimation: true,
              primaryXAxis: NumericAxis(
                isVisible: false,
                // Additional range padding is applied to y axis
                //rangePadding: ChartRangePadding.round,
                  minimum: 0,
                  maximum: 25,
                  interval: 4,
                  plotOffset: 0
              ),
              primaryYAxis: NumericAxis(
                isVisible:false,
                minimum: 0,
              ),
            //  primaryYAxis.isVisible = false,
              series: <ChartSeries>[
                ColumnSeries<Pollution, int>(
                    dataSource: [

                      Pollution(01, 30,barColor),
                      Pollution(02, 40,barColor),
                      Pollution(03, 10,barColor),
                      Pollution(04, 30,barColor),
                      Pollution(05, 40,barColor),
                      Pollution(06, 10,barColor),
                      Pollution(07, 30,barColor),
                      Pollution(08, 40,barColor),
                      Pollution(09, 10,barColor),
                      Pollution(10, 30,barColor),
                      Pollution(11, 40,barColor),
                      Pollution(12, 10,barColor),
                      Pollution(13, 30,barColor),
                      Pollution(14, 40,barColor),
                      Pollution(15, 10,barColor),
                      Pollution(16, 30,barColor),
                      Pollution(17, 40,barColor),
                      Pollution(18, 10,barColor),
                      Pollution(19, 30,barColor),
                      Pollution(20, 40,barColor),
                      Pollution(21, 10,barColor),
                      Pollution(22, 30,barColor),
                      Pollution(23, 40,barColor),
                      Pollution(24, 10,barColor),
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
