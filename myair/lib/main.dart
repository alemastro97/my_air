
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Modules/PollutantAgent.dart';
import 'package:myair/Services/Database_service/FirebaseDatabaseHelper.dart';
import 'package:myair/Views/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myair/Views/ProfilePage.dart';
import 'package:myair/Widgets/Opening_page_widgets/LogoWidget.dart';
import 'Constants/theme_constants.dart';
import 'Modules/UserAccount.dart';
import 'Modules/info_pollution.dart';
import 'Services/Arpa_service/SensorRetriever.dart';
import 'Services/Database_service/DatabaseHelper.dart';
import 'Services/Geolocator_service/GeolocatorService.dart';
import 'package:myair/Modules/Sensor.dart';

import 'Services/Google_Service/GoogleSignIn.dart';
import 'Views/Permission_view/PermissionPage.dart';

// kInfo data
var kInfo = ValueNotifier<List<ValueNotifier<InfoPollution>>>(
    [
      ValueNotifier(InfoPollution('PM10', amount: 23.0)),
      ValueNotifier(InfoPollution('PM2.5', amount: 23.0)),
      ValueNotifier(InfoPollution('NO2', amount: 37.0)),
      ValueNotifier(InfoPollution('SO2', amount: 15.0)),
      ValueNotifier(InfoPollution('O3', amount: 17.0)),
      ValueNotifier(InfoPollution('CO', amount: 12.0))
    ]
);

// Sensor list
List<SensorModule> sensorList = [];

//bool logged = false ;
UserAccount actualUser;
bool permissions = false;
//int nU = 0;
var x;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // DB for user management
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
    super.initState();

    // App initialization
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

        );
      }),
    );
  }

  // App initialization
  initialization() async {
    // Geolocation permission management
    permissions = await GeolocationView().checkPermissions();

    // Database for sensor, user and data tables
    DatabaseHelper databaseHelper = DatabaseHelper();
    FirebaseDatabaseHelper().getShadowUserAccount();
    // Data management
    DailyUnitData d = DailyUnitData();
    d.initializeValues();

    // Reward management
    PollutantAgent p = PollutantAgent();
    p.initialize(1,100,100,100,100,100);

    databaseHelper.getDailyData();
    // Get actual user
    actualUser = await databaseHelper.getUserAccount();

    // get sensor list saved in the db
    sensorList = await databaseHelper.getSensorList();
    GoogleSignInProvider().logout();

    // if sensors not present in the db then call api to fetch them
    if(sensorList.length == 0){
      await fetchSensorsFromAPI();
      sensorList = await databaseHelper.getSensorList();
    }

    /*await*/ GeolocationView().getCurrentLocation();
    setState(() {
      _start = true;
    });
  }
}

class SplashScreen extends StatefulWidget {
  _SplashScreen createState() => _SplashScreen();
}

// Splash management during app startup
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
                   )
                 ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}






























