import 'package:flutter/material.dart';
import 'package:myair/Views/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Services/Arpa_service/sensors.dart';
import 'Services/Database_service/database_helper.dart';
import 'Services/Geolocator_service/GeolocatorService.dart';
import 'package:myair/Modules/sensor.dart';

List<Sensor> sensorList = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DatabaseHelper databaseHelper = DatabaseHelper();
  sensorList = await databaseHelper.getSensorList();
  if(sensorList.length == 0){
    await fetchSensorsFromAPI();
    sensorList = await databaseHelper.getSensorList();
    print("Entrato");
  }
  await GeolocationView().getCurrentLocation();
  print("Upload all sensors: " + sensorList.length.toString());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Google SignIn';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(primarySwatch: Colors.deepOrange),
    home: HomePage(),
  );
}