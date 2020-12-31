import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:myair/Views/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myair/Views/profile_page.dart';

import 'Constants/theme_constants.dart';
import 'Modules/UserAccount.dart';
import 'Services/Arpa_service/sensors.dart';
import 'Services/Database_service/database_helper.dart';
import 'Services/Database_service/firebase_database_user.dart';
import 'Services/Geolocator_service/GeolocatorService.dart';
import 'package:myair/Modules/sensor.dart';

import 'Views/Graph_view/bar_charts_view.dart';

//TODO insert in the db a user
List<Sensor> sensorList = [];
bool logged = false ;
userAccount actualUser;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DatabaseHelper databaseHelper = DatabaseHelper();
  actualUser = await databaseHelper.getUserAccount();

  //print(actualUser.firebaseId + " " + actualUser.email );
  //FirebaseDb_gesture db = FirebaseDb_gesture();
//  databaseHelper.deleteDB();
  sensorList = await databaseHelper.getSensorList();
  if(sensorList.length == 0){
    await fetchSensorsFromAPI();
    sensorList = await databaseHelper.getSensorList();
  }
  await GeolocationView().getCurrentLocation();
  print("Upload all sensors: " + sensorList.length.toString());

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
          },
       home: actualUser == null ?  ProfilePage() : HomePage(),
        );
      }),
    );
  }
}