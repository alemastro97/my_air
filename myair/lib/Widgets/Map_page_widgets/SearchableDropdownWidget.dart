import 'package:flutter/material.dart';

import 'package:myair/Modules/Unit.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';

class SearchableDropdownWidget extends StatefulWidget {

  final List<Unit> stationIdList;

  //Function reference to the setState of MapPageWidget in order to recenter the map position to the station selected
  final Function recenter;

  //Constructor
  SearchableDropdownWidget({Key key, this.stationIdList, this.recenter}): super (key: key);

  @override
  _SearchableDropdownWidget createState() => _SearchableDropdownWidget();
}

class _SearchableDropdownWidget extends State<SearchableDropdownWidget> {
  Unit selectedValue;
  final List<DropdownMenuItem> items = [];

  @override
  void initState() {
    var stationIdList = widget.stationIdList;
    //Creation of the item of the list based on the station name
    stationIdList.map((station) =>{
      items.add(
        DropdownMenuItem(
            child: Text(
              station.unit,
            ),
            //Value used to find the station selected
            value: station.unit
        ),
      )
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:Container(
        color: Theme.of(context).brightness == Brightness.light ? Colors.white : Theme.of(context).backgroundColor,
        child:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children:[
              SizedBox(
                height: 5,
              ),
              //Default plugin widget
              SearchableDropdown.single(
                menuBackgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white : Theme.of(context).backgroundColor,
                items: items,
                value: selectedValue,
                hint: "Search a station",
                searchHint: "Search a station",
                onChanged: (value) {
                  setState(() {
                    widget.recenter(getCoordinates(value));
                  });
                },
                isExpanded: true,
              )
            ],
          ),
        ),
      ),
    );
  }

  //get coordinates of the station referred by the name
  Unit getCoordinates(String stationName){
    for (var station in widget.stationIdList) {
      if(station.unit == stationName) return station;
    }
    return null;
  }
}