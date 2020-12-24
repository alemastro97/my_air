import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Services/Arpa_service/sensordata.dart';
import 'package:myair/Services/Database_service/database_helper.dart';

import 'package:myair/Widgets/Home_page_statistics_widgets/pie_chart.dart';


Timer timer;
class GeolocationView{
  // ignore: non_constant_identifier_names
  LatLng user_position;
  DailyUnitData d =  new DailyUnitData();
  static final GeolocationView _geolocationView = GeolocationView._internal();

  factory GeolocationView() {
    // TODO: implement initState

    return _geolocationView;

  }

  LatLng getLastUserposition(){
    return user_position;
  }

  GeolocationView._internal(){timer = Timer.periodic(Duration(seconds: 30), (Timer t) => getCurrentLocation());}

  void dispose(){
    timer?.cancel();
  }

  getCurrentLocation() async{
    final geoposition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    user_position = new LatLng(geoposition.latitude, geoposition.longitude);
    print(geoposition.latitude.toString() + " " + geoposition.longitude.toString());
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    var instantData = await d.setSensorsDataAverage(DatabaseHelper(), geoposition.latitude, geoposition.longitude,50000);
    //print("lsllsslsllslslsll" + sensor.length.toString());
    for( var item in instantData) {
      print(" -------------------------------------------"+ item.pollutantName +"------------------------------------------------------");
       print(item.value);
       print(item.timestamp);
      print("_________________________________________________________________________________________________________________");
    }
  }

}
