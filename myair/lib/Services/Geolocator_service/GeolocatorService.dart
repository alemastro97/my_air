import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';



Timer timer;
class GeolocationView{
  // ignore: non_constant_identifier_names
  LatLng user_position;

  static final GeolocationView _geolocationView = GeolocationView._internal();

  factory GeolocationView() {
    // TODO: implement initState

    return _geolocationView;

  }

  LatLng getLastUserposition(){
    return user_position;
  }

  GeolocationView._internal(){timer = Timer.periodic(Duration(seconds: 5), (Timer t) => getCurrentLocation());}

  void dispose(){
    timer?.cancel();
  }

  getCurrentLocation() async{
    final geoposition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    user_position = new LatLng(geoposition.latitude, geoposition.longitude);
  }

}
