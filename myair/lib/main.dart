import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Views/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myair/Views/ProfilePage.dart';
import 'package:http/http.dart' as http;
import 'package:myair/Widgets/Opening_page_widgets/LogoWidget.dart';
import 'package:provider/provider.dart';
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
import 'Views/Permission_view/PermissionPage.dart';
import 'Widgets/Permission_page_widgets/PermissionPageWidget.dart';
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
bool permissions = false;
int nU = 0;
var x;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}















class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}


//TODO HOME WIDGET
class _MyAppState extends State<MyApp> {
  static final String title = 'Google SignIn';
  var _start;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
    _start = false;
  }
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
          home:_start ?
         ( !permissions ?
          PermissionPage()
              :
          (actualUser == null) ?
          ProfilePage()
            :
          HomePage()):

          SplashScreen(),

       /*         SafeArea(
                  child: Scaffold(
                    body: Container(
                      child: AnimatedCrossFade(
              crossFadeState:
                        _start ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 3000),
              firstChild: (!permissions
                        ? PermissionPage()
                        : (actualUser == null)
                            ? ProfilePage()
                            : HomePage()),
              secondChild: SplashScreen(),
                        firstCurve: Curves.easeOut,
                        secondCurve: Curves.easeIn,
                        sizeCurve: Curves.bounceOut,
            ),
                    ),
                  ),
                )*/
            //   :
        //   PermissionPage(),

        );
      }),
    );
  }



initialization() async {
  permissions = await GeolocationView().checkPermissions();
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

  await GeolocationView().getCurrentLocation(); ///Todo Starting geolocator thread
  setState(() {
    _start = true;
  });
  //print(actualUser.toString());
  //print("Permi" + permissions.toString() );
}
}

class SplashScreen extends StatefulWidget {
  _SplashScreen createState() => _SplashScreen();
}
class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:Container(
            child: Column(
              children: <Widget>[
               LogoImport(),
                Expanded(
                  flex: 2,
                   child:SpinKitFadingFour(
                     color: Color.fromRGBO(113, 85, 149, 1.0),
                     controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                   ) /*SpinKitSquareCircle(
                     color: Colors.white,
                     size: 50.0,
                     controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                   )*/
                 ),

              ],
            ),
          ),
        ),
      ),
    );
  }

}






























