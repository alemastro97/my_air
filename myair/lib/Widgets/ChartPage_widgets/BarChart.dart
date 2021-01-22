

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Views/Graph_view/ChartPage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
class BarChart extends StatelessWidget{
  final List<Pollution> data;
  BarChart({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Container(
        child: SfChartTheme(
          data: SfChartThemeData(
          ),
          child:SfCartesianChart(
              plotAreaBorderColor: Colors.transparent,
              enableAxisAnimation: true,
              primaryXAxis:CategoryAxis(interval: 6,) ,
              series: <ChartSeries>[
                ColumnSeries<Pollution, String>(
                    dataSource: data,
                    xValueMapper: (Pollution p, _) => p.hour,
                    yValueMapper: (Pollution p, _) => p.value,
                    pointColorMapper: (Pollution data, _) => data.color,
                )
              ]
          ),
        ),
      ),
    );
  }
}

