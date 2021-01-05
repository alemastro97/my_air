import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myair/Views/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myair/Views/profile_page.dart';
import 'package:http/http.dart' as http;
import 'Constants/theme_constants.dart';
import 'Modules/UserAccount.dart';
import 'Services/Arpa_service/sensors.dart';
import 'Services/Database_service/database_helper.dart';
import 'Services/Database_service/firebase_database_user.dart';
import 'Services/Geolocator_service/GeolocatorService.dart';
import 'package:myair/Modules/sensor.dart';
import 'dart:io' as Io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'Views/Graph_view/bar_charts_view.dart';

List<Sensor> sensorList = [];
//bool logged = false ;
userAccount actualUser = null;
Io.File top_image = null;
var x;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DatabaseHelper databaseHelper = DatabaseHelper();


  //print(actualUser.firebaseId + " " + actualUser.email );
  //FirebaseDb_gesture db = FirebaseDb_gesture();
  //databaseHelper.deleteDB();
  actualUser = await databaseHelper.getUserAccount();
  if(actualUser != null){_getImage();}
  // x = await databaseHelper.getCountUser();
  //print("number of users " + x.toString());
  sensorList = await databaseHelper.getSensorList();

  if(sensorList.length == 0){
    await fetchSensorsFromAPI();
    sensorList = await databaseHelper.getSensorList();
  }

  await GeolocationView().getCurrentLocation();
  print("Upload all sensors: " + sensorList.length.toString());
  print(actualUser.toString());
  runApp(MyApp());
}
_getImage() async {
  if (actualUser.img != '') {
    top_image = await writeImageTemp(actualUser.img, 'image_2');
  }
}
Future<Io.File> writeImageTemp(String base64Image, String imageName) async {
  final dir = await getTemporaryDirectory();
  await dir.create(recursive: true);
  final tempFile = Io.File(path.join(dir.path, imageName));
  await tempFile.writeAsBytes(base64.decode(base64Image));
  return tempFile;
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

