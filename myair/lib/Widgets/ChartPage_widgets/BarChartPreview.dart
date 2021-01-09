import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
class BarChartPreview extends StatelessWidget{
  final List<double> data;

  BarChartPreview({Key key, this.data}) : super(key: key);

  List<Pollution> dataSource = [];
  @override
  Widget build(BuildContext context) {
    _generateData();
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
              primaryXAxis: CategoryAxis(
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
                ColumnSeries<Pollution, String>(
                    dataSource: dataSource,
                    xValueMapper: (Pollution p, _) => p.hour,
                    yValueMapper: (Pollution p, _) => p.value,
              pointColorMapper: (Pollution data, _) => data.color
                )
              ]
          ),
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