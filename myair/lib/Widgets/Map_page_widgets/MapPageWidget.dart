
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:user_location/user_location.dart';
import 'package:latlong/latlong.dart';

import 'package:myair/Modules/Unit.dart';
import 'package:myair/Modules/PinModule.dart';
import 'package:myair/Services/Geolocator_service/GeolocatorService.dart';
import 'package:myair/Widgets/Map_page_widgets/SearchWidget.dart';
import 'package:myair/Widgets/Map_page_widgets/StationInfoWidget.dart';
import 'package:myair/main.dart';

//Definition of the map widget
class MapPageWidget extends StatefulWidget{
  @override
  MapPageWidgetState createState() => MapPageWidgetState();
}

class MapPageWidgetState extends State <MapPageWidget> with TickerProviderStateMixin {
  //Local variables
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
  //Ends of Local variables


  //override functions: initState and build
  @override
  initState() {
    stationIdList = sensorList.elementAt(0).retrieveUnit(sensorList);
    currentlySelectedPin = new PinInformation( //Create the default pin
      pinPath: 'assets/Map-Pin.png',
      avatarPath: 'assets/Map-Pin.png',
      location: new LatLng(0,0),
      locationName: 'Default',
    );
    displayCaps = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Definition of the user option in order to recenter the map and create the markers
    userLocationOptions = UserLocationOptions(
      updateMapLocationOnPositionChange: false,
      showMoveToCurrentLocationFloatingActionButton:false,
      context: context,
      mapController: mapController,
      markers: markers,

    );
    return Stack(
      children: [
        //Flutter map -> google map was paid
        new FlutterMap(
          options: MapOptions(
            center: GeolocationService().getLastUserPosition(),
            zoom: 15.0, //Starting zoom
            maxZoom: 17.0, //Max zoom of the map
            minZoom: 10.0, //Minimum zoom of the map
            plugins: [
              UserLocationPlugin(),
            ],
          ),
          layers: [
            new TileLayerOptions(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c']
            ),
            MarkerLayerOptions( markers: _buildMarkersOnMap()), //Dynamic build of the markers
            userLocationOptions,
          ],
          mapController: mapController, // Definition of the controller
        ),

        //search widget
        SearchWidget(
          stationIdList: stationIdList,
          recenter:recenterMap,
          currentSearchPercent: currentSearchPercent,
          currentExplorePercent: currentExplorePercent,
          isSearchOpen: isSearchOpen,
          animateSearch: animateSearch,
          onHorizontalDragUpdate: onSearchHorizontalDragUpdate,
          onPanDown: () => animationControllerSearch?.stop(),
        ),

        //Top widget of the page -> center user location and station values
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child:
                      Container(
                    decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Theme.of(context).backgroundColor,),
                      child: MaterialButton(
                          shape: CircleBorder(),
                            // button color
                            child: InkWell(
                              splashColor: Colors.white, // inkwell color
                              child: SizedBox(
                                  height:
                                  (71 / 815.0 * MediaQuery.of(context).size.height),
                                  width:
                                  (71 / 815.0 * MediaQuery.of(context).size.height),
                                  child: Icon(Icons.my_location)),
                              onTap: () {
                                recenterMap(null);
                              },
                            ),
                          ),
                      )
                    ),
                    if (displayCaps)
                      Expanded(flex:3,child: StationInfoWidget(  actualStation: currentlySelectedPin))else Expanded(flex: 3,child: Container(width: 0.0,height: 0.0,),)
                  ],
                ),

              ],
            ),),
        ),

      ],

    );
  }
  //Ends of override functions

  //Widget functions:
  //-recenterMap: used by searchable_dropdown_widget to set the pin information and recenter the map
  recenterMap(Unit station){
    setState(() { //call a set state with a new position
      if(station != null) { //-> the one of the station selected
        displayCaps = true;
        currentlySelectedPin.locationName = station.unit;
        currentlySelectedPin.location = station.position;
        mapController.move(station.position , 17.0);
        animateSearch(false);
      }else{
        mapController.move(GeolocationService().getLastUserPosition(), 15.0); //-> the one related to the user
      }
    });
  }

  //-_buildMarkersOnMap: used by MarkerLayerOptions's FlutterMap, it takes the station list and builds all the markers
  //with their onTap function
  List<Marker> _buildMarkersOnMap() { //Creation of the marker for each station
    markers = stationIdList.map((Station) {
      return  Marker(
          width: 80.0,
          height: 80.0,
          point: Station.position,
          builder: (ctx) => GestureDetector(
            onTap: () {
              setState(() {
                displayCaps = true;
                currentlySelectedPin.locationName=Station.unit;
                currentlySelectedPin.location = Station.position;
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

  //Animation function for what concern the movement of the search widget
  get currentSearchPercent => max(0.0, min(1.0, offsetSearch / (6*MediaQuery.of(context).size.width/7)));
  get currentExplorePercent => max(0.0, min(1.0, offsetExplore / (6*MediaQuery.of(context).size.width/7)));
  void animateSearch(bool open) {
    animationControllerSearch = AnimationController(duration: Duration(milliseconds: 1 + (800 * (isSearchOpen ? currentSearchPercent : (1 - currentSearchPercent))).toInt()),vsync: this);
    curve = CurvedAnimation(parent: animationControllerSearch, curve: Curves.ease);
    animation = Tween(
        begin: offsetSearch,
        end: open ?
        6*MediaQuery.of(context).size.width / 7
            :
        0.0).animate(curve)
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
  // search drag callback
  void onSearchHorizontalDragUpdate(details) {
    offsetSearch -= details.delta.dx;
    if (offsetSearch < 0) {
      offsetSearch = 0;
    } else if (offsetSearch >= (6*MediaQuery.of(context).size.width/7)) {
      offsetSearch = (6*MediaQuery.of(context).size.width / 7);
    }
    setState(() {});
  }



}