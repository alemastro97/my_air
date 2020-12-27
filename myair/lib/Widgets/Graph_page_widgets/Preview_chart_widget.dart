
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartCardWidget extends StatelessWidget{
  final String element;

  const ChartCardWidget({Key key, this.element}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    element,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                FittedBox(
                  fit: BoxFit.fitHeight,

                  child: Text(
                    "24 Hours • Exposure",
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ),

                Text("6,500"),/// TODO Medium Value
              ],
            ),
            Flexible(
              child:SfCartesianChart(
                  primaryXAxis: NumericAxis(
                    // X axis is hidden now
                      isVisible: false
                  ),
                  primaryYAxis: NumericAxis(
                  // X axis is hidden now
                  isVisible: false
              )
              ),),///Insert chart
          ],
        ),
      ),
    );
  }

}
