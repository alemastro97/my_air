
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/unit.dart';

import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:myair/Widgets/Map_page_widgets/search_back_widget.dart';
import 'package:myair/Widgets/Map_page_widgets/search_widget.dart';
import 'package:myair/helper/ui_helper.dart';
import 'package:user_location/user_location.dart';
import 'package:myair/Modules/PinModule.dart';
import 'package:myair/Services/Geolocator_service/GeolocatorService.dart';
import 'package:myair/Widgets/Map_page_widgets/Information_capsule_widget.dart';
import 'package:myair/Modules/sensor.dart';
import 'package:myair/main.dart';

class MapWidget extends StatefulWidget{
  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State <MapWidget> with TickerProviderStateMixin {
  ///Local variables
  AnimationController animationControllerSearch;
  MapController mapController = MapController();
  UserLocationOptions userLocationOptions;
  List<Marker> markers = [];
  List<Unit> stationIdList=[];
  PinInformation  currentlySelectedPin;
  bool displayCaps;
  bool infoWindowVisible = false;
  GlobalKey<State> key = new GlobalKey();
  var offsetSearch = 0.0;
  var offsetExplore = 0.0;
  CurvedAnimation curve;
  Animation<double> animation;
  bool isSearchOpen = false;
  ///Ends of Local variables
  get currentSearchPercent => max(0.0, min(1.0, offsetSearch / (347 - 68.0)));
  get currentExplorePercent => max(0.0, min(1.0, offsetExplore / (760.0 - 122.0)));
  void animateSearch(bool open) {
    animationControllerSearch = AnimationController(
        duration: Duration(
            milliseconds: 1 + (800 * (isSearchOpen ? currentSearchPercent : (1 - currentSearchPercent))).toInt()),
        vsync: this);
    curve = CurvedAnimation(parent: animationControllerSearch, curve: Curves.ease);
    animation = Tween(begin: offsetSearch, end: open ? 347.0 - 68.0 : 0.0).animate(curve)
      ..addListener(() {
        setState(() {
          offsetSearch = animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          isSearchOpen = open;
        }
      });
    animationControllerSearch.forward();
  }
  /// search drag callback
  void onSearchHorizontalDragUpdate(details) {
    offsetSearch -= details.delta.dx;
    if (offsetSearch < 0) {
      offsetSearch = 0;
    } else if (offsetSearch > (347 - 68.0)) {
      offsetSearch = 347 - 68.0;
    }
    setState(() {});
  }
  ///override functions: initState and build
  @override
  initState() {
    stationIdList = getStationList(sensorList);
    currentlySelectedPin = new PinInformation(
        pinPath: 'assets/Map-Pin.png',
        avatarPath: 'assets/Map-Pin.png',
        location: new LatLng(0,0),
        locationName: 'Default',
        labelColor: Colors.black
    );
    displayCaps = false;
    //mapController.move(GeolocationView().getLastUserposition(),10);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
   userLocationOptions = UserLocationOptions(
     updateMapLocationOnPositionChange: false,
     showMoveToCurrentLocationFloatingActionButton: false,
      context: context,
      mapController: mapController,
      markers: markers,

    );
    return Stack(
      children: [
        new FlutterMap(
          options: MapOptions(
            center: GeolocationView().getLastUserposition(),
            zoom: 15.0,
            plugins: [
              UserLocationPlugin(),
            ],
          ),
          layers: [
            new TileLayerOptions(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c']
            ),
            MarkerLayerOptions( markers: _buildMarkersOnMap()),
            userLocationOptions,
          ],
          mapController: mapController,
        ),
        if(displayCaps)StationInfoWidget(actualStation: currentlySelectedPin),
       // SearchableDropdownWidget (stationIdList: stationIdList, recenter : recenterMap),

        //search menu background


        //search
        SearchWidget(
          currentSearchPercent: currentSearchPercent,
          currentExplorePercent: currentExplorePercent,
          isSearchOpen: isSearchOpen,
          animateSearch: animateSearch,
          onHorizontalDragUpdate: onSearchHorizontalDragUpdate,
          onPanDown: () => animationControllerSearch?.stop(),
        ),
        //search back
        SearchBackWidget(
          stationIdList: stationIdList,
          recenter:recenterMap ,
          currentSearchPercent: currentSearchPercent,
          animateSearch: animateSearch,
        ),
      ],

    );
  }
  ///Ends of override functions
  ///Widget functions:
  ///-recenterMap: used by searchable_dropdown_widget to set the pin information and recenter the map
  recenterMap(Unit station){
    setState(() {
      if(station != null) {
        displayCaps = true;
        currentlySelectedPin.locationName = station.unit;
        currentlySelectedPin.location = new LatLng(station.lat,station.lng);
        mapController.move(new LatLng(station.lat,station.lng) , 17.0);
      }else{
        mapController.move(GeolocationView().getLastUserposition(), 10.0);
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
  }
  //TODO ingrandimento del marker quando viene selezionato e omnbre
  ///-_buildMarkersOnMap: used by MarkerLayerOptions's FlutterMap, it takes the station list and builds all the markers
  ///with their onTap function
  List<Marker> _buildMarkersOnMap() {
    markers = stationIdList.map((Station) {
      return  Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(Station.lat ,Station.lng),
        //anchorPos: anchorPos,
        builder: (ctx) => GestureDetector(
          onTap: () {
            setState(() {
              //TODO insert station values
              displayCaps = true;
              currentlySelectedPin.locationName=Station.unit;
              currentlySelectedPin.location = LatLng(Station.lat,Station.lng);
          });
          },
          child:Container(
            child:  Icon(
              Icons.location_pin,
              color: Colors.red,
              size: 30,
            ),
          ),
        )
      );
    }).toList();
    return markers;
  }
  ///-getStationList:
  getStationList(List<Sensor> sensor)  {
    var idunit = "";
    List<Unit> unitList = List();
    Unit unit;
    for (var sensoritem in sensor) {
      if (idunit != sensoritem.idunit) {
        unit = new Unit(sensoritem.id, sensoritem.unit, sensoritem.idunit, double.parse(sensoritem.lat), double.parse(sensoritem.lng));
        unitList.add(unit);
      }
      idunit = unit.idunit;
    }
    print("Number of stations: " + unitList.length.toString());
    return unitList;
  }
///End of widget's functions
}