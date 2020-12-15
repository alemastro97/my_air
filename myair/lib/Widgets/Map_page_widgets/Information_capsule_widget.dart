
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/PinModule.dart';

class StationInfoWidget extends StatelessWidget{
  final PinInformation actualStation;
  StationInfoWidget({Key key, this.actualStation}): super (key: key);

  @override
  Widget build(BuildContext context) {
    return  AnimatedPositioned(
      duration: Duration(milliseconds: 200),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.all(20),
            height: 70,
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
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: 50, height: 50,
                    // this Container’s child will be a ClipOval,
                    // which in turn contains an Image as a child.
                    // A ClipOval is used so it can crop
                    // the image into a circle
                    child: ClipOval(
                      child:
                      Image.asset(
                          'assets/Map-Pin.png',
                          fit: BoxFit.contain
                      ),
                    ),
                  ), // first widget
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              actualStation.locationName,
                              style: TextStyle(color: actualStation.labelColor)
                          ),
                          Text(
                              'Latitude: ${actualStation.location.latitude.toString()}',
                              style: TextStyle(fontSize: 12, color: Colors.grey)
                          ),
                          Text('Longitude: ${actualStation.location.longitude.toString()}',
                              style: TextStyle(fontSize: 12, color: Colors.grey)
                          )
                        ], // end of Column Widgets
                      ), // end of Column
                    ), // end of Container
                  ), // second widget
                ]
            ),
          ) // end of Container
      ),

    );
  }


}