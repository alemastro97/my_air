
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/PinModule.dart';

class StationInfoWidget extends StatelessWidget{
  final PinInformation actualStation;
  StationInfoWidget({Key key, this.actualStation}): super (key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(

       // margin: EdgeInsets.all(20),
           //     height: 70,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  blurRadius: 20,
                  offset: Offset.zero,
                  color: Colors.grey.withOpacity(0.5)
              )
            ]
        ),

          child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.fitHeight,
              child:Text(
                  "Location selected: ${actualStation.locationName}",
                textAlign: TextAlign.center,
                //  style: TextStyle(color: actualStation.labelColor)
              ),),
              FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.fitHeight,
                child: Text(
                    '( ${actualStation.location.latitude.toString()}, ${actualStation.location.longitude.toString()})',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),

            ], // end of Column Widgets
          ),
            ),
    );
  }


}