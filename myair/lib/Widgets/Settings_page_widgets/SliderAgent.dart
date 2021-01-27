

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/ActualData.dart';
import 'package:myair/Services/Database_service/DatabaseHelper.dart';
import 'package:myair/Services/Database_service/FirebaseDatabaseHelper.dart';
import 'package:myair/main.dart';

class SliderAgent extends StatefulWidget{

  final min = 0;
  final max; //Max value: limit of the arpa
  final index; //Index of the agent
  final change; //boolean that says if the value is changed

  //Constructor
   SliderAgent({Key key, this.max, this.index, this.change}) : super(key: key);

   @override
   _SliderAgentState createState() => _SliderAgentState();

}

class _SliderAgentState extends State<SliderAgent>{

  var rating ; //Actual rate of the slider

  //Initial state
  @override
  void initState() {
    super.initState();
    rating  = actualUser.notificationLimits.elementAt(widget.index).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //Title of the slider
        Text("Set values to send notification's about " +
            ActualValue().getActualData().value.elementAt(widget.index).value.name),
        //Slider
        SliderTheme(
          //Slider colors in case it is disabled
            data: SliderTheme.of(context).copyWith(
              disabledActiveTrackColor: Colors.grey[400],
              disabledInactiveTrackColor: Colors.grey[100],
              disabledThumbColor: Colors.grey[400],
            ),
            //Slider that based on the index of the agent decides how many section of values done
            child: Slider(
              activeColor: Theme.of(context).brightness == Brightness.light
                  ? null
                  : Theme.of(context).accentColor,
              value: rating,
              max: widget.max,
              min: 0.0,
              label: "$rating",
              divisions: widget.index == 0
                  ? 10
                  : widget.index == 1
                      ? 5
                      : widget.index == 2
                          ? 10
                          : widget.index == 3
                              ? 20
                              : widget.index == 4
                                  ? 10
                                  : 10,
              //Function activated when the user is changing the value
              onChanged: widget.change
                  ? (newRating) {
                      setState(() {
                        rating = newRating;
                      });
                    }
                  : null,
              //Function activated when the user ends
              onChangeEnd: (newRating) {
                actualUser.notificationLimits[widget.index] = newRating.toInt();
                actualUser.updateUser();
              },
            )),
      ],
    );
  }
}
