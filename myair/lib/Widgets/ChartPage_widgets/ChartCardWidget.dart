
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Widgets/ChartPage_widgets/LineChart.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/PieChart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:myair/Widgets/ChartPage_widgets/BarChartPreview.dart';

import '../../main.dart';
import 'BarChart.dart';

class ChartCardWidget extends StatefulWidget{
  final data;
  final int index;
  final Function changeContainer;
  const ChartCardWidget({Key key,  this.index, ValueListenable<List<double>> this.data, this.changeContainer}) : super(key: key);

  _ChartCardWidgetState createState() => _ChartCardWidgetState();


}

class _ChartCardWidgetState extends State<ChartCardWidget>{
  var _height = 0.0;
  var _myAnimatedWidget;

  @override
  Widget build(BuildContext context) {
    _height == 0 ? _height =  MediaQuery.of(context).size.height/7 : null;
    _myAnimatedWidget == null ? _myAnimatedWidget = MinimizePreview(index: widget.index, data: widget.data): null;
    return
       GestureDetector(onTap: (){
         setState(() {
           _height == MediaQuery.of(context).size.height/7 ?  _height =  MediaQuery.of(context).size.width : _height = MediaQuery.of(context).size.height/7;
           _height == MediaQuery.of(context).size.height/7 ?  _myAnimatedWidget = MinimizePreview(index: widget.index, data: widget.data) : _myAnimatedWidget = ExpandedPreview(index: widget.index,  data: widget.data);
           widget.changeContainer(_height);
         });
       },child:AnimatedContainer(
      height: _height,
      duration: Duration(milliseconds: 200),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width/100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/30),//color:  Theme.of(context).cardTheme.color,
      ),

        child:Card(
          elevation: 1,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds:200),
            transitionBuilder: (Widget child, Animation <double> animation) => ScaleTransition(child: child, scale: animation,),
            child: _myAnimatedWidget,
          ),
        ),


      ),
    );
  }

}

class MinimizePreview extends StatelessWidget{
  final int index;
  final data;
  const MinimizePreview({Key key, this.index, this.data}) : super(key: key);
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
                 "Actual average value:" + kInfo.value.elementAt(index).value.amount.toStringAsFixed(2).toString(),
               ),/// TODO Medium Value
             ],
           ),
         ),
       ),
    ValueListenableBuilder(
    builder:(BuildContext context, List<double> value, Widget child){
    return Expanded(
         flex:1,
         child:BarChartPreview(data: value,),
       );},
      valueListenable: this.data,
    ),
     ],
   );
  }

}
class  ExpandedPreview extends StatefulWidget{
  final data;
  final int index;
  const ExpandedPreview({Key key, this.index, this.data}) : super(key: key);
  _ExpandedPreviewState createState() => _ExpandedPreviewState();
}
class _ExpandedPreviewState extends State<ExpandedPreview>{
  //bool _bar;
  @override
  void initState() {
  //  _bar = true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder:(BuildContext context, List<double> value, Widget child){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text(
                                kInfo.value.elementAt(widget.index).value.name,
                                style:
                                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text(
                                "24 Hours • Exposure",
                              ),
                            ),
                          ),
                        ],
                      ),
                      ),
                    /*  ButtonTheme(
                        shape: CircleBorder(),
                        minWidth: MediaQuery.of(context).size.width / 20,
                        height: MediaQuery.of(context).size.width / 20,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              _bar = !_bar;
                            });
                          },
                          child: Icon(Icons.swap_horiz_outlined),
                        ),
                      ),
                      */
                    ],
                  ),
                Expanded(
                  flex: 3,
                  child: BarChart(data: value,),
                ),
              ],
            ),
          ),
        ],
      );
    },
    valueListenable: this.widget.data,
    );
  }

}
/* */