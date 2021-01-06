import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Constants/pollution_graph_constants.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/PieChart.dart';

class InfoList extends StatelessWidget{
  const InfoList({
    Key key,@required this.index,@required this.text,
  }) : super(key:key);

  final  int index;
  final String text;

  @override
  Widget build(BuildContext context) {
  return  Flexible(
    child:Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child:Container(
            width: MediaQuery.of(context).size.width/30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kNeumorphicColors.elementAt( index % kNeumorphicColors.length),
            ),
          ),
        ),
        Expanded(
            child:
            Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width/100),
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  text.capitalize() ,
                ),
              ),
            )),
      ],
    ),
  );
  }

}
extension StringExtension on String{
  String capitalize(){
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}