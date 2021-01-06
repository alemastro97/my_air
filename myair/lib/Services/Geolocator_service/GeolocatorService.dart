import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Services/Arpa_service/SensorDataRetriever.dart';
import 'package:myair/Services/Database_service/DatabaseHelper.dart';

import 'package:myair/Widgets/Home_page_statistics_widgets/PieChart.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/AgentPieChart.dart';
import 'package:myair/Widgets/Pop_Up_Notification/notification.dart';

Timer timer;

class GeolocationView{
  // ignore: non_constant_identifier_names
  LatLng user_position;
  DailyUnitData d =  new DailyUnitData();
  static final GeolocationView _geolocationView = GeolocationView._internal();
  final Notifications _notifications =  Notifications();
  factory GeolocationView() {

    return _geolocationView;

  }

  LatLng getLastUserposition(){
    return user_position;
  }

  GeolocationView._internal(){ this._notifications.initNotifications();timer = Timer.periodic(Duration(seconds: 120), (Timer t) => getCurrentLocation());}

//  void dispose(){
//    timer?.cancel();
//  }

  // Get the current location and set the actual values
  // Called every two minutes
  getCurrentLocation() async{
    final geoposition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    user_position = new LatLng(geoposition.latitude, geoposition.longitude);

    var instantData = await d.setSensorsDataAverage(DatabaseHelper(), DateTime.now().hour, geoposition.latitude, geoposition.longitude,50000);
    for( var item in instantData) {
      print(" -------------------------------------------"+ item.pollutantName +"------------------------------------------------------");
      print(item.value);
      print(item.timestamp);
      print(item.sensor);
      print("_________________________________________________________________________________________________________________");
    }

    for(var i = 0; i < kInfo.length; i++)
      kInfo.elementAt(i).amount > Limits.elementAt(i) ? this._notifications.pushNotification()  : null;
  }

}
