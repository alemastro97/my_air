import 'package:flutter/material.dart';
import 'package:myair/Modules/Unit.dart';
import 'package:latlong/latlong.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class SearchableDropdownWidget extends StatefulWidget {
  final List<Unit> stationIdList;
  final Function recenter;
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
    stationIdList.map((Station) =>{
      items.add(
        DropdownMenuItem(
          child: Text(
              Station.unit,

          ),
          value: Station.unit//new LatLng(double.parse(Station.lat),double.parse(Station.lng)),

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
        color: Theme.of(context).backgroundColor,
        child:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children:[
              SizedBox(
                height: 5,
              ),
              SearchableDropdown.single(
                menuBackgroundColor: Theme.of(context).backgroundColor,
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

  Unit getCoordinates(String stationName){
    for (var station in widget.stationIdList) {
      if(station.unit == stationName) return station;
    }
  }
}