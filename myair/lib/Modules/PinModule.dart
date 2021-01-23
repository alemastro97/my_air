import 'package:latlong/latlong.dart';
//Class that describes the pin in the map and their composition
class PinInformation {
  String pinPath;
  String avatarPath;
  LatLng location;
  String locationName;
  PinInformation({this.pinPath,this.avatarPath,this.location,this.locationName});
}