

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Services/Database_service/DatabaseHelper.dart';
import 'package:myair/Services/Database_service/FirebaseDatabaseHelper.dart';

import '../../main.dart';
class SliderAgent extends StatefulWidget{
  final min = 0;
  final max;
  final index;
  final change;
   SliderAgent({Key key, this.max, this.index, this.change}) : super(key: key);
  _SliderAgentState createState() => _SliderAgentState();
}
class _SliderAgentState extends State<SliderAgent>{
  var rating ;
  @override
  void initState() {
    super.initState();
    rating  = actualUser.notificationLimits.elementAt(widget.index).toDouble();
  }
  @override
  Widget build(BuildContext context) {
    print(kInfo.value.elementAt(widget.index).value.name + "" + widget.index.toString());
    return

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Set values to send notification's about " + kInfo.value.elementAt(widget.index).value.name),

    SliderTheme(
    data: SliderTheme.of(context).copyWith(
    disabledActiveTrackColor: Colors.grey[400],
    disabledInactiveTrackColor: Colors.grey[100],
    disabledThumbColor: Colors.grey[400],
    ),
    child:Slider(

            value: rating,
            max: widget.max,
            min: 0.0,
            label: "$rating",
            divisions: widget.index == 0 ?
            10
                :
            widget.index == 1 ?
            5
                :
            widget.index == 2 ?
            10
                :
            widget.index == 3 ?
            20
                :
            widget.index == 4 ?
            10
                :
            10
            ,
            onChanged: widget.change ? (newRating){

                  setState(() {
                    rating = newRating;
                  });

              }: null,

            onChangeEnd: (newRating){
              actualUser.notificationLimits[widget.index] = newRating.toInt();
              DatabaseHelper().deleteUser();
              DatabaseHelper().insertUser(actualUser);
              FirebaseDatabaseHelper().updateUser();
            },
          )),
        ],
      )


;
  }

}
