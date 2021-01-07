
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:myair/Services/Geolocator_service/GeolocatorService.dart';
import 'package:myair/Widgets/Opening_page_widgets/LogoWidget.dart';
import 'package:myair/main.dart';
import 'package:permission_handler/permission_handler.dart';
class PermissionPageWidget extends StatefulWidget{
  @override
  _PermissionPageWidgetState createState() => _PermissionPageWidgetState();
}
class _PermissionPageWidgetState extends State<PermissionPageWidget> with WidgetsBindingObserver {
  PermissionStatus _status;

  @override
  void initState() {
   // runFirst();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final granted = await Permission.locationAlways.isGranted;
      if (granted) {
          actualUser == null ? Navigator.pushReplacementNamed(context, '/Login') : Navigator.pushReplacementNamed(context, '/HomePage');
        } else {
         // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      }
    }


  @override
  Widget build(BuildContext context) {
    GeolocationView().checkPermissions();
    print("£");
   return SafeArea(
     child:  Container(
       decoration: BoxDecoration(
         image: DecorationImage(
           image: AssetImage("assets/images/login_background.png"),
           fit: BoxFit.cover,
         ),
       ),
       child:Padding(
         padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 10, right: MediaQuery.of(context).size.width / 10,bottom: MediaQuery.of(context).size.width / 4, top: MediaQuery.of(context).size.width / 4),
         child: Center(
           child: Container(
             height: MediaQuery.of(context).size.height / 2,
             child: Card(
               elevation: 1.0,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/20),
               ),
               color: Colors.transparent.withOpacity(0.5),
               child: Container(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     LogoImport(),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Divider(),
                     ),
                     Flexible(flex: 1,child:
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         children: [
                           Expanded(
                             flex: 2,
                             child: Text(
                               "Your current location will be displayed on the map and used to retrieve accurate data regarding pollution in your area\n"
                                   "Please turn on the option of permanent location",
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                 color: Colors.white,
                               ),
                             ),
                           ),
                         //  Divider(),
                           Expanded(
                             child: GestureDetector(
                               onTap: () async{
                                 await Permission.locationAlways.status.then(_updateStatus);
                                 _requestPerms();

                               },
                               child: Container(child: Column(
                                 children: [
                                   Divider(),
                                   Text(
                                     "Go to App Settings",
                                     textAlign: TextAlign.center, 
                                     style: TextStyle(
                                       fontSize: 14,
                                       color: Colors.white,
                                       fontWeight: FontWeight.bold
                                     ),
                                   ),
                                 ],
                               ),),
                             ),
                           ),
                       //    Divider(),
                           Expanded(
                             child: GestureDetector(
                               onTap: (){ SystemChannels.platform.invokeMethod('SystemNavigator.pop');},
                               child: Container(child: Column(
                                 children: [
                                   Divider(),
                                   Text(
                                     "Don't Allow",
                                     textAlign: TextAlign.center,
                                     style: TextStyle(
                                       color: Colors.white,
                                       fontSize: 14,
                                     ),
                                   ),
                                 ],
                               ),),
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
  runFirst() async {

    await Permission.locationAlways.status.then(_updateStatus);

    _requestPerms();
    if (_status == PermissionStatus.granted) {
      actualUser==null ? Navigator.pushReplacementNamed(context, '/Login') : Navigator.pushReplacementNamed(context, '/HomePage');
    } else if (_status == PermissionStatus.denied) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }
  void _requestPerms() async {
    Map<Permission, PermissionStatus> statuses = await
    [
      Permission.locationWhenInUse,
      Permission.locationAlways
    ].request();



    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      _updateStatus(PermissionStatus.granted);
      openAppSettings();
    }

    //  switch (status) {
    //    case PermissionStatus.disabled:
    //      await PermissionHandler().
    //      break;
    //  }
    //  _updateStatus(status);
    }

    void _updateStatus(PermissionStatus value) {
      setState(() {
        _status = value;
      });
    }
  }

