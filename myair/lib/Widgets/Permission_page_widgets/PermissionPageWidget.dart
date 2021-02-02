import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:myair/Services/Geolocator_service/GeolocatorService.dart';
import 'package:myair/Widgets/Opening_page_widgets/LogoWidget.dart';
import 'package:myair/main.dart';

import 'package:permission_handler/permission_handler.dart';

class PermissionPageWidget extends StatefulWidget {
  @override
  _PermissionPageWidgetState createState() => _PermissionPageWidgetState();
}

class _PermissionPageWidgetState extends State<PermissionPageWidget> with WidgetsBindingObserver {

  PermissionStatus _status; //Status of the permission about the location permissions

  //Initialization of the widget

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  //Controller: when the user go to the location settings it freeze the application and
  //block the life cycle of th application. When the user click the return button it checks the
  //new permissions and, if is AlwaysGranted it redirects the user to the right page
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final granted = await Permission.locationAlways.isGranted;
      if (granted) {
        actualUser == null
            ? Navigator.pushReplacementNamed(context, '/Login')
            : Navigator.pushReplacementNamed(context, '/HomePage');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    GeolocationService().checkPermissions();
    print("£");
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 10,
              right: MediaQuery.of(context).size.width / 10,
              bottom: MediaQuery.of(context).size.width / 4,
              top: MediaQuery.of(context).size.width / 4),
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / 20),
                ),
                color: Colors.transparent.withOpacity(0.5),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      LogoImport(),
                      Padding(
                       padding: const EdgeInsets.symmetric(horizontal:8.0),
                       child: Divider(),
                     ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right:8.0,bottom:8.0,left:8.0),
                          child: Column(
                            children: [
                              Expanded(
                                flex:2,
                                child: AutoSizeText(
                                  "Your current location will be displayed on the map and used to retrieve accurate data regarding pollution in your area."
                                      "Please turn on the option of permanent location",
                                  textAlign: TextAlign.start,
                                  maxLines: 5,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await Permission.locationAlways.status
                                        .then(_updateStatus);
                                    _requestPerms();
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Divider(),
                                        //If the user click this text is redirect to the system settings of the app
                                        Flexible(
                                          child: ClipRect(
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                "Go to App Settings",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(

                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // If the user doesn't allow the local permission the app is closed
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    SystemChannels.platform
                                        .invokeMethod('SystemNavigator.pop');
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Divider(),
                                        Flexible(
                                          child: ClipRect(
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                "Don't Allow",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  //fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  //Function that open the permission in the system settings
  void _requestPerms() async {
    await [Permission.locationWhenInUse, Permission.locationAlways].request();

    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      _updateStatus(PermissionStatus.granted);
      openAppSettings();
    }
  }

  //Update the status of the widget
  void _updateStatus(PermissionStatus value) {
    setState(() {
      _status = value;
    });
  }
}
