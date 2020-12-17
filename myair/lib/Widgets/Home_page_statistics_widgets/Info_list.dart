import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Constants/pollution_graph_constants.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/pie_chart.dart';

class InfoList extends StatelessWidget{
  const InfoList({
    Key key,@required this.index,@required this.text,
  }) : super(key:key);

  final  int index;
  final String text;

  @override
  Widget build(BuildContext context) {
  return Expanded(
    flex: 1,
    child:Padding(
      padding: const EdgeInsets.only(left: 8.0,bottom: 8.0),
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(flex: 3,
              child: Align(
                alignment: Alignment.centerRight,
                child: FractionallySizedBox(
                  heightFactor: 0.5,widthFactor: 0.5,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kNeumorphicColors.elementAt(index % kNeumorphicColors.length),
                      ),),
                  ),
                ),
              ),
            ),
            Expanded(flex: 8,
              child: Container(
                child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                    text.capitalize()  ,
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }

}
extension StringExtension on String{
  String capitalize(){
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}