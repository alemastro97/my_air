
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myair/Views/Graph_view/ChartPage.dart';

import 'package:myair/Widgets/ChartPage_widgets/BarChartPreview.dart';

import '../../main.dart';
import 'BarChart.dart';

class ChartCardWidget extends StatefulWidget{
  final data; //List of data per hour
  final int index; //Index of the pollutant agent
  final Function changeContainer; // Reference to the setState function in the GraphPage to change the dimension of the container
  final List<Pollution> hourSorted; //List of the hour sorted per actual hour

  const ChartCardWidget({Key key,  this.index, ValueListenable<List<double>> this.data, this.changeContainer, this.hourSorted}) : super(key: key);

  _ChartCardWidgetState createState() => _ChartCardWidgetState();


}

//Card widget that displays the bar chart as a preview and if you touch it, it displays the full bar chart
class _ChartCardWidgetState extends State<ChartCardWidget>{

  var _height = 0.0;
  var _myAnimatedWidget; // Widget that contains the new widget changed thanks to the animatedContainer + GestureDetector

  @override
  Widget build(BuildContext context) {
    //Set the first size and widget at the opening page, it's not possible set it in the initState because there is not the possibility to use MediaQuery
    _height == 0 ? _height =  MediaQuery.of(context).size.height/7 : null;
    _myAnimatedWidget == null ? _myAnimatedWidget = MinimizePreview(index: widget.index, data: widget.data,hourSorted: widget.hourSorted): null;
    return
       GestureDetector(onTap: (){
         setState(() {
           //Switching of the view based on the dimension of the container:
           // _height == MediaQuery.of(context).size.height/7 --> MinimizePreview
           // _height == MediaQuery.of(context).size.width --> ExpandedPreview
           _height == MediaQuery.of(context).size.height / 7
              ? _height = MediaQuery.of(context).size.width
              : _height = MediaQuery.of(context).size.height / 7;
          _height == MediaQuery.of(context).size.height / 7
              ? _myAnimatedWidget = MinimizePreview(
                  index: widget.index,
                  data: widget.data,
                  hourSorted: widget.hourSorted,
                )
              : _myAnimatedWidget = ExpandedPreview(
                  index: widget.index,
                  data: widget.data,
                  hourSorted: widget.hourSorted,
                );
          widget.changeContainer(_height); //Call the referene of the function setState in the parent View
         });
       },
      child: AnimatedContainer(
        height: _height,
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.width /
                  30),
        ),
        child: Card(
          elevation: 1,
          child: AnimatedSwitcher( //Add an animation to the transition between the two widgets
            duration: Duration(milliseconds: 200), //Duration of the transition
            transitionBuilder: (Widget child, Animation<double> animation) =>
                ScaleTransition(
              child: child,
              scale: animation,
            ),
            child: _myAnimatedWidget, //New widget
          ),
        ),
      ),
    );
  }
}

//This is the card with its content: Name of the pollutant agent, its actual media and the preview of the bar chart
class MinimizePreview extends StatelessWidget{
  final int index;
  final data;
  final List<Pollution>hourSorted;

  const MinimizePreview({Key key, this.index, this.data, this.hourSorted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Row(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
     children: <Widget>[
       Expanded(
         flex: 3,
         child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               FittedBox( //Fitted box in order to scale the text based on the height of the device
                 fit: BoxFit.fitHeight,
                 child: Text(
                   kInfo.value.elementAt(index).value.name,
                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                 ),
               ),

               FittedBox( //Fitted box in order to scale the text based on the height of the device
                 fit: BoxFit.fitHeight,
                 child: Text(
                   "24 Hours • Exposure",
                 ),
               ),
               FittedBox( //Fitted box in order to scale the text based on the height of the device
                 fit: BoxFit.fitHeight,
                 child: Text(
                   "Actual average value:" + kInfo.value.elementAt(index).value.amount.toStringAsFixed(2).toString(),
                 ),
               ),
             ],
           ),
         ),
       ),
    ValueListenableBuilder( //Listen the changes of the value in order to update the chart in Real-Time
    builder:(BuildContext context, List<double> value, Widget child){
      _generateData(value);
    return Expanded(
         flex:1,
         child:BarChartPreview(
           data:hourSorted,
         ),
       );
    },
      valueListenable: this.data, //Data passed in which stay tuned
    ),
     ],
   );
  }

  // Associate the hours sorted to the data in order to have a sorted array that start from the old measure to the actual hour measure
   _generateData (List<double> data){
    var date = new DateTime.now();
    for(var i = 0; i < hourSorted.length; i++){
      if(i + date.hour < hourSorted.length -1)
      hourSorted.elementAt(i).value = data.elementAt(i + date.hour + 1);
      else hourSorted.elementAt(i).value = data.elementAt(i -((24 - date.hour)-1));
    }
  }
}

class  ExpandedPreview extends StatefulWidget{
  final List<Pollution> hourSorted;
  final data;
  final int index;
  const ExpandedPreview({Key key, this.index, this.data, this.hourSorted}) : super(key: key);
  _ExpandedPreviewState createState() => _ExpandedPreviewState();
}

class _ExpandedPreviewState extends State<ExpandedPreview>{
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder:(BuildContext context, List<double> value, Widget child){
        _generateData(value);
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                    ],
                  ),
                Expanded(
                  flex: 3,
                  child: BarChart(data: widget.hourSorted,),
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

  // Associate the hours sorted to the data in order to have a sorted array that start from the old measure to the actual hour measure
  _generateData (List<double> data){
    var date = new DateTime.now();
    for(var i = 0; i < widget.hourSorted.length; i++){
      if(i + date.hour < widget.hourSorted.length -1) widget.hourSorted.elementAt(i).value =data.elementAt(i + date.hour + 1);
      else widget.hourSorted.elementAt(i).value = data.elementAt(i - ((24 - date.hour) - 1));
    }
  }
}
