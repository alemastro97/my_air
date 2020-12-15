import 'dart:ui';

import 'package:latlong/latlong.dart';

class PinInformation {
  String pinPath;
  String avatarPath;
  LatLng location;
  String locationName;
  Color labelColor;

  PinInformation({this.pinPath,this.avatarPath,this.location,this.locationName,this.labelColor});
}