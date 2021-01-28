import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:myair/Modules/PinModule.dart';

//Information box about the station selected by tapping a pin or by the SearchableDropdownWidget
class StationInfoWidget extends StatelessWidget {

  final PinInformation actualStation; //Pin Selected
  StationInfoWidget({Key key, this.actualStation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: (71 / 815.0 * MediaQuery.of(context).size.height),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  blurRadius: 20,
                  offset: Offset.zero,
                  color: Colors.grey.withOpacity(0.5))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.fitHeight,
                //Location name
                child: Text(
                  "Location selected: ${actualStation.locationName}",
                  textAlign: TextAlign.center,
                ),
              ),
              FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.fitHeight,
                //Location coordinates
                child: Text(
                  '( ${actualStation.location.latitude.toString()}, ${actualStation.location.longitude.toString()})',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ], // end of Column Widgets
          ),
        ),
      ),
    );
  }
}
