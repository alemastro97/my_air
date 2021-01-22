import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myair/Views/Graph_view/ChartPage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
class BarChartPreview extends StatelessWidget{
  final List<Pollution> data;

  BarChartPreview({Key key, this.data}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return  SafeArea(
      child: Container(
         child: SfChartTheme(
          child: SfCartesianChart(
              plotAreaBorderColor: Colors.transparent,
              primaryXAxis: CategoryAxis(
                isVisible: false,
                  minimum: 0,
                  maximum: 25,
                  interval: 4,
                  plotOffset: 0
              ),
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
              ]
          ),
        ),
      ),
    );
  }

}




