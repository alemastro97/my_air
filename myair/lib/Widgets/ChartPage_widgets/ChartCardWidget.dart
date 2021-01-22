
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myair/Views/Graph_view/ChartPage.dart';

import 'package:myair/Widgets/ChartPage_widgets/BarChartPreview.dart';

import '../../main.dart';
import 'BarChart.dart';

class ChartCardWidget extends StatefulWidget{
  final data;
  final int index;
  final Function changeContainer;
  final List<Pollution> hourSorted;
  const ChartCardWidget({Key key,  this.index, ValueListenable<List<double>> this.data, this.changeContainer, this.hourSorted}) : super(key: key);

  _ChartCardWidgetState createState() => _ChartCardWidgetState();


}

class _ChartCardWidgetState extends State<ChartCardWidget>{
  var _height = 0.0;
  var _myAnimatedWidget;

  @override
  Widget build(BuildContext context) {
    _height == 0 ? _height =  MediaQuery.of(context).size.height/7 : null;
    _myAnimatedWidget == null ? _myAnimatedWidget = MinimizePreview(index: widget.index, data: widget.data,hourSorted: widget.hourSorted): null;
    return
       GestureDetector(onTap: (){
         setState(() {
           _height == MediaQuery.of(context).size.height/7 ?  _height =  MediaQuery.of(context).size.width : _height = MediaQuery.of(context).size.height/7;
           _height == MediaQuery.of(context).size.height/7 ?  _myAnimatedWidget = MinimizePreview(index: widget.index, data: widget.data,hourSorted: widget.hourSorted,) : _myAnimatedWidget = ExpandedPreview(index: widget.index,  data: widget.data,hourSorted: widget.hourSorted,);
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
               ),
             ],
           ),
         ),
       ),
    ValueListenableBuilder(
    builder:(BuildContext context, List<double> value, Widget child){
      _generateData(value);
    return Expanded(
         flex:1,
         child:BarChartPreview(data:hourSorted,),
       );},
      valueListenable: this.data,
    ),
     ],
   );
  }
   _generateData (List<double> data){
    var date = new DateTime.now();
//    print("HOUR LENGHT" +widget.hourSorted.lenght.toString());
    for(var i = 0; i < hourSorted.length; i++){
      print(i);
      if(i + date.hour < hourSorted.length -1)
      hourSorted.elementAt(i).value = data.elementAt(i + date.hour + 1);
      else hourSorted.elementAt(i).value = data.elementAt(i -((24 - date.hour)-1));
    //dataSource.add(new Pollution(DateFormat('MM-dd  kk:00').format(date.subtract(Duration(hours:  date.hour + (24 - i)))), data.elementAt(date.hour + (24 - i)), Colors.teal));
    }
 //   for(var i = 0; i <= date.hour; i++){
    //dataSource.add(new Pollution(DateFormat('MM-dd  kk:00').format(date.subtract(Duration(hours: date.hour - i))), data.elementAt(i), Colors.teal));
 //   }
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
        _generateData(value);
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
  _generateData (List<double> data){
    var date = new DateTime.now();
//    print("HOUR LENGHT" +widget.hourSorted.lenght.toString());
    for(var index = 0; index < data.length ; index++) print( index.toString() + "" + data.elementAt(index).toString());
    for(var i = 0; i < widget.hourSorted.length; i++){

      if(i + date.hour < widget.hourSorted.length -1) {
        widget.hourSorted.elementAt(i).value =
            data.elementAt(i + date.hour + 1);
      } else {
        widget.hourSorted.elementAt(i).value =
            data.elementAt(i - ((24 - date.hour) - 1));
      }
      print("" + widget.hourSorted.elementAt(i).hour +  " " + widget.hourSorted.elementAt(i).value.toString());
      //dataSource.add(new Pollution(DateFormat('MM-dd  kk:00').format(date.subtract(Duration(hours:  date.hour + (24 - i)))), data.elementAt(date.hour + (24 - i)), Colors.teal));
    }
    //   for(var i = 0; i <= date.hour; i++){
    //dataSource.add(new Pollution(DateFormat('MM-dd  kk:00').format(date.subtract(Duration(hours: date.hour - i))), data.elementAt(i), Colors.teal));
    //   }
  }
}
/* */