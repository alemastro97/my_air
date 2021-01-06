
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/PieChart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:myair/Widgets/ChartPage_widgets/BarChartPreview.dart';

import '../../main.dart';
import 'BarChart.dart';

class ChartCardWidget extends StatefulWidget{
  final data;
  final int index;
  const ChartCardWidget({Key key,  this.index, this.data}) : super(key: key);

  _ChartCardWidgetState createState() => _ChartCardWidgetState();


}

class _ChartCardWidgetState extends State<ChartCardWidget>{
  var _height = 0.0;
  var _myAnimatedWidget;
  @override
  Widget build(BuildContext context) {
    _height == 0 ? _height =  MediaQuery.of(context).size.height/7 : null;
    _myAnimatedWidget == null ? _myAnimatedWidget = MinimizePreview(index: widget.index): null;
    return  AnimatedContainer(
      height: _height,
      duration: Duration(milliseconds: 200),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width/100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/30),//color:  Theme.of(context).cardTheme.color,
      ),
      child: GestureDetector(
        child:Card(
          elevation: 1,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds:200),
            transitionBuilder: (Widget child, Animation <double> animation) => ScaleTransition(child: child, scale: animation,),
            child: _myAnimatedWidget,
          ),
        ),

        onTap: (){
          setState(() {
            _height == MediaQuery.of(context).size.height/7 ?  _height =  MediaQuery.of(context).size.width : _height = MediaQuery.of(context).size.height/7;
            _height == MediaQuery.of(context).size.height/7 ?  _myAnimatedWidget = MinimizePreview(index: widget.index) : _myAnimatedWidget = ExpandedPreview(index: widget.index);

          });
        },
      ),
    );
  }

}

class MinimizePreview extends StatelessWidget{
  final int index;
  const MinimizePreview({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   return Row(
     // mainAxisSize: MainAxisSize.max,
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
     children: <Widget>[
       Expanded(
         flex: 3,
         child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             //crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               FittedBox(
                 fit: BoxFit.fitHeight,
                 child: Text(
                   kInfo.value.elementAt(index).value.name,
                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                 ),
               ),

               FittedBox(
                 fit: BoxFit.fitHeight,

                 child: Text(
                   "24 Hours • Exposure",
                 ),
               ),

               Text(
                 kInfo.value.elementAt(index).value.amount.toString(),
               ),/// TODO Medium Value
             ],
           ),
         ),
       ),
       Expanded(
         flex:1,
         child:BarChartPreview(),
       ),
     ],
   );
  }

}

class ExpandedPreview extends StatelessWidget{

  final int index;
  const ExpandedPreview({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    kInfo.value.elementAt(index).value.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),

              Padding(
               padding: const EdgeInsets.only(bottom:8.0),
                child: FittedBox(
                  fit: BoxFit.fitHeight,

                  child: Text(
                    "24 Hours • Exposure",
                  ),
                ),
              ),

              Expanded(
                flex:3,
                child:BarChart(),
              ),

            ],
          ),
        ),

      ],
    );
  }

}
/* */