
// Get the sensor list closed to the user
import 'package:geolocator/geolocator.dart';
import 'package:myair/Modules/sensor.dart';
import 'dart:math' as Math;

Future<List<Sensor>> getSensorListClosedtoUser(List<Sensor> sl, double ulatitude, double ulongitude, int utolerance) async {
  int count = sl.length; // Count the number of map entries in the db

  List<Sensor> sensorList = List<Sensor>();
  Sensor sensor;
  var distanceMeters, distanceMeters2;
  var lat, lng;

  print("Checking DB sensors (" + count.toString() + ")");

  for (sensor in sl) {
    lat = sensor.lat;
    lng =sensor.lng;
    distanceMeters = Geolocator.distanceBetween(ulatitude, ulongitude, double.parse(lat), double.parse(lng));
    distanceMeters2 = getDistance(ulatitude, ulongitude, double.parse(lat), double.parse(lng));

    if (distanceMeters < utolerance) {
      sensorList.add(sensor);
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
