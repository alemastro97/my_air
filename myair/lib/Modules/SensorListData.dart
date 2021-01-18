
import 'package:geolocator/geolocator.dart';
import 'package:myair/Modules/Sensor.dart';
import 'dart:math' as Math;

// Get the sensor list closed to the user
Future<List<SensorModule>> getSensorListClosedtoUser(List<SensorModule> sl, double ulatitude, double ulongitude, int utolerance) async {
  int count = sl.length; // Count the number of map entries in the db

  List<SensorModule> sensorList = [];
  List<SensorItem> sensorListOrdered = [];

  SensorItem item;

  var distanceMeters;
  var lat, lng;
  int i,j;

  print("Checking DB sensors (" + count.toString() + ")");

  for (j = 0; j < sl.length; j++) {
    lat = sl[j].position.latitude;
    lng = sl[j].position.longitude;
    distanceMeters = Geolocator.distanceBetween(ulatitude, ulongitude, lat, lng);

    if (distanceMeters < utolerance) {
      item = SensorItem(sl[j].sensor, distanceMeters);
      item.distance = distanceMeters;
      print(item.sensor + "-" + item.distance.toString());
      sensorListOrdered.add(item);
    }
  }

  // Sorting
  sensorListOrdered.sort((a, b) => a.distance.compareTo(b.distance));
  for (i = 0; i < sensorListOrdered.length; i++) {
    print(sensorListOrdered[i].sensor + "-" + sensorListOrdered[i].distance.toString());
    for (j = 0; j < sl.length; j++) {
      if (sl[j].sensor == sensorListOrdered[i].sensor) {
        sensorList.add(sl[j]);
        break;
      }
    }
  }

  return sensorList;
}

double getDistance(double lat1, lon1, lat2, lon2) {
  int R = 6371; // km
  double x = (lon2 - lon1) * Math.cos((lat1 + lat2) / 2);
  double y = (lat2 - lat1);
  double distance = Math.sqrt(x * x + y * y) * R;

  return distance;
}

class SensorItem {
  String sensor;
  double distance;

  SensorItem(String sensor,double distance) {
    this.sensor = sensor;
    this.distance = distance;
  }
}