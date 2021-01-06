import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Views/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myair/Views/ProfilePage.dart';
import 'package:http/http.dart' as http;
import 'Constants/theme_constants.dart';
import 'Modules/UserAccount.dart';
import 'Modules/info_pollution.dart';
import 'Services/Arpa_service/SensorRetriever.dart';
import 'Services/Database_service/DatabaseHelper.dart';
import 'Services/Database_service/FirebaseDatabaseHelper.dart';
import 'Services/Geolocator_service/GeolocatorService.dart';
import 'package:myair/Modules/Sensor.dart';
import 'dart:io' as Io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'Views/Graph_view/ChartPage.dart';
var kInfo = ValueNotifier<List<ValueNotifier<InfoPollution>>>(
    [
      ValueNotifier(InfoPollution('PM10', amount: 23.0)),
      ValueNotifier(InfoPollution('PM2.5', amount: 23.0)),
      ValueNotifier(InfoPollution('NO2', amount: 37.0)),
      ValueNotifier(InfoPollution('SO2', amount: 15.0)),
      ValueNotifier(InfoPollution('O3', amount: 17.0)),
      ValueNotifier(InfoPollution('O3', amount: 12.0))
    ]
);
List<SensorModule> sensorList = [];
//bool logged = false ;
UserAccount actualUser = null;

var x;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DatabaseHelper databaseHelper = DatabaseHelper();
  DailyUnitData d = DailyUnitData();
  d.initializeValues();
  //databaseHelper.deleteDB();
  actualUser = await databaseHelper.getUserAccount();
  sensorList = await databaseHelper.getSensorList();

  if(sensorList.length == 0){
    await fetchSensorsFromAPI();
    sensorList = await databaseHelper.getSensorList();
  }
  GeolocationView().getCurrentLocation(); ///Starting geolocator thread
  runApp(MyApp());
}

//TODO HOME WIDGET
class MyApp extends StatelessWidget {
  static final String title = 'Google SignIn';

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: kLightTheme,
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeProvider.of(context),
          routes: {
            "/HomePage": (_) => new HomePage(),
            "/Login": (_) => new ProfilePage(),

          },
          home: (actualUser == null) ?
         ProfilePage()
            :
          HomePage(),
        );
      }),
    );
  }
}

