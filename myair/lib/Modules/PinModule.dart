import 'dart:ui';

import 'package:latlong/latlong.dart';

class PinInformation {
  String pinPath;
  String avatarPath;
  LatLng location;
  String locationName;
  PinInformation({this.pinPath,this.avatarPath,this.location,this.locationName});
}