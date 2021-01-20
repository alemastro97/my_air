import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Modules/PollutantAgent.dart';
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
   //   static const platform = const MethodChannel(name)
      PollutantAgent().set_values(DateTime.now().hour,DateTime.now().day,
          kInfo.value.elementAt(0).value.amount,
        kInfo.value.elementAt(1).value.amount,
        kInfo.value.elementAt(2).value.amount,
        kInfo.value.elementAt(3).value.amount,
        kInfo.value.elementAt(4).value.amount,
        kInfo.value.elementAt(5).value.amount);
      int aqi = PollutantAgent().getAqi(
          kInfo.value.elementAt(0).value.amount,
          kInfo.value.elementAt(1).value.amount,
          kInfo.value.elementAt(2).value.amount,
          kInfo.value.elementAt(3).value.amount,
          kInfo.value.elementAt(4).value.amount,
          kInfo.value.elementAt(5).value.amount);
      d.getPM10Values().value.forEach((element) {print("------"+element.toString());});
      if(150 > aqi){actualUser.sethourSafe(1);}
      else{if(aqi > 400){actualUser.weeklyMissionFailed = false;}}
      if(actualUser.notificationSend)
      {
        for (var i = 0; i < kInfo.value.length; i++)
        if(  kInfo.value.elementAt(i).value.amount > actualUser.notificationLimits.elementAt(i)) {
          this._notifications.pushNotification();

        }}
      if(actualUser.notificationReward)
      {

        PollutantAgent().get_pm10_notify() || PollutantAgent().get_pm25_notify() ||
            PollutantAgent().get_so2_notify() ||PollutantAgent().get_no2_notify() ||
            PollutantAgent().get_o3_notify() ||PollutantAgent().get_co_notify()
              ? this._notifications.pushNotificationReward()
              : null;
      }
    }
  }
}



