import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Services/Arpa_service/SensorDataRetriever.dart';
import 'package:myair/Services/Database_service/DatabaseHelper.dart';

import 'package:myair/Widgets/Home_page_statistics_widgets/PieChart.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/AgentPieChart.dart';
import 'package:myair/Widgets/Pop_Up_Notification/notification.dart';

import '../../main.dart';

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
  Future<bool> checkPermissions() async {
  print("");
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
     // permissions = false;
      return false;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
  //      print("Deny");
//        permissions = false;
        return false;
      }
    }
    //permissions = true;
    return true;
    //  return await Geolocator.getCurrentPosition();
  }
  LatLng getLastUserposition(){
    return user_position;
  }

  GeolocationView._internal(){ this._notifications.initNotifications();timer = Timer.periodic(Duration(seconds: 30), (Timer t) => getCurrentLocation());}

//  void dispose(){
//    timer?.cancel();
//  }

  // Get the current location and set the actual values
  // Called every two minutes
  getCurrentLocation() async{
  //  await checkPermissions();
    if (permissions){
      final geoposition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      user_position = new LatLng(geoposition.latitude, geoposition.longitude);

      var instantData = await d.setSensorsDataAverage(
          DatabaseHelper(),
          DateTime.now().hour,
          geoposition.latitude,
          geoposition.longitude,
          50000);
      for (var item in instantData) {
        print(" -------------------------------------------" +
            item.pollutantName +
            "------------------------------------------------------");
        print(item.value);
        print(item.timestamp);
        print(item.sensor);
        print(
            "_________________________________________________________________________________________________________________");
      }

      for (var i = 0; i < kInfo.value.length; i++)
        kInfo.value.elementAt(i).value.amount > Limits.elementAt(i)
            ? this._notifications.pushNotification()
            : null;
    }
  }
}
