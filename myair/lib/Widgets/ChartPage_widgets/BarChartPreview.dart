import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Views/Graph_view/ChartPage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class BarChartPreview extends StatelessWidget{
  final List<Pollution> data; //24 hours average values

  //Construct
  BarChartPreview({Key key, this.data}) : super(key: key);


  //It shows a bar chart without axis as a preview of the chart
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Container(
         child: SfChartTheme(
          child: SfCartesianChart(

              plotAreaBorderColor: Colors.transparent,
              //Definition of the X axis
              primaryXAxis: CategoryAxis(
                isVisible: false,
                  minimum: 0,
                  maximum: 25,
                  interval: 4,
                  plotOffset: 0
              ),
            //Definition of the Y axis
              primaryYAxis: NumericAxis(
                isVisible:false,
                minimum: 0,
              ),

             series: <ChartSeries>[
                ColumnSeries<Pollution, String>(
                    dataSource: data,
                    xValueMapper: (Pollution p, _) => p.hour,
                    yValueMapper: (Pollution p, _) => p.value,
                    pointColorMapper: (Pollution data, _) => data.color
                )
              ],

          ),
        ),
      ),
    );
  }

}




