import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Modules/PollutantAgent.dart';
import 'package:myair/Services/Database_service/DatabaseHelper.dart';
import 'package:myair/Widgets/Pop_Up_Notification/notification.dart';
import 'package:myair/main.dart';
import 'package:myair/Services/RemoteView/RemoteViewUpdater.dart';


Timer timer;

class GeolocationView{

  LatLng userPosition; // Actual user position
  DailyUnitData d =  new DailyUnitData(); //Take the reference of daily unit data
  static final GeolocationView _geolocationView = GeolocationView._internal();
  final Notifications _notifications =  Notifications(); // Create the notification class

  //We handle it as a SINGLETON
  factory GeolocationView() {return _geolocationView;}

  //Allows us to check if the local permissions are enabled on the device,
  // if they are not, the procedure doesn't start
  Future<bool> checkPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if GPS is working on the device
    if (!serviceEnabled) {
      return false;
    }
    //Check if the location permissions are enabled
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    //Check the status of the permission
    if (permission == LocationPermission.denied) {
      //Request to set the location permissions on always
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return false;
      }
    }
    return true;
  }

  //user position getter
  LatLng getLastUserPosition(){return userPosition;}

  //Starts the time that call the function every 30 seconds
  GeolocationView._internal(){
    this._notifications.initNotifications();
    timer = Timer.periodic(Duration(seconds: 30), (Timer t) => getCurrentLocation());
  }


  // Get the current location and set the actual values
  // Called every 30 seconds
  getCurrentLocation() async{
    if (permissions){
      final geoPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      userPosition = new LatLng(geoPosition.latitude, geoPosition.longitude);
      print(userPosition.latitude.toString() + " " + userPosition.longitude.toString());
      await d.setSensorsDataAverage(
          DatabaseHelper(),
          DateTime.now().hour,
          geoPosition.latitude,
          geoPosition.longitude,
          50000);
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
      RemoteViewUpdater().updateRemoteView(
          kInfo.value.elementAt(0).value.amount.round().toString(),
          kInfo.value.elementAt(1).value.amount.round().toString(),
          kInfo.value.elementAt(5).value.amount.round().toString(),
          aqi.round().toString());
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



