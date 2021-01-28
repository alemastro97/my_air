import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Constants/pollution_graph_constants.dart';

class InfoList extends StatelessWidget{

  final  int index;
  final String text;

  const InfoList({
    Key key,@required this.index,@required this.text,
  }) : super(key:key);

  //It defines the circle with the color for each agent and its name
  @override
  Widget build(BuildContext context) {
    return  Flexible(
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Box with the colored pointer for the agent
          Flexible(
            child:Container(
              width: MediaQuery.of(context).size.width/30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kNeumorphicColors.elementAt( index % kNeumorphicColors.length),
              ),
            ),
          ),

          //Name of the agent
          Expanded(
              child:
              Container(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.width/100,left:MediaQuery.of(context).size.width/100,right:MediaQuery.of(context).size.width/100),
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    text.capitalize(),
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