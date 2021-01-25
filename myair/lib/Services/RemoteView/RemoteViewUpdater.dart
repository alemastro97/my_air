import 'package:flutter/services.dart';

class RemoteViewUpdater {
  static const platform = const MethodChannel('com.example.myair/homeWidget');
  updateRemoteView(String pm10,String pm25, String co, String aqi) {
    try {
      platform.invokeMethod('updateHomeWidget', {
        'PM10':pm10,
        'PM2.5': pm25,
        'CO': co,
        'AQI': aqi}
     );
    } on PlatformException catch (e) {
      // ignore: unnecessary_statements
      "Failed to update the screen widget: '${e.message}'.";
    }
  }
}
