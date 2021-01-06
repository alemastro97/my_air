import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Services/Arpa_service/SensorRetriever.dart';
import 'package:myair/Services/Database_service/DatabaseHelper.dart';
import 'package:myair/Widgets/Map_page_widgets/sensor_detail.dart';
import 'package:myair/Widgets/Map_page_widgets/unit_list.dart';

import '../../Modules/Sensor.dart';
class SensorList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return SensorListState();
  }
}

class SensorListState extends State<SensorList> {

  DatabaseHelper databaseHelper = DatabaseHelper();

  List<SensorModule> sensorList;
  List<SensorModule> filteredSensors = List();

  int count = 0;
  int result;

  @override
  Widget build(BuildContext context) {

    if (sensorList == null) {
      //sensorList = List<Sensor>();
/*      Future<List<Sensor>> sensorList = fetchSensorsFromAPI();
      sensorList.then((sensorList) {
    //    updateListView(databaseHelper);
      }); */
    }

    return Scaffold(

      appBar: AppBar(
        title: Text('Sensors'),
      ),

      body: Column (
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'Enter sensor name',
              ),
              onChanged: (string) {
                setState(() {
                  filteredSensors = sensorList
                      .where((u) => u.unit
                      .toLowerCase()
                      .contains(string.toLowerCase()))
                      .toList();
                });
              },
            ),
            Expanded(
                child: getSensorListView()
            ),
          ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UnitList(filteredSensors, "Unit list"),
              )
          );
        },

        tooltip: 'Unit list',

        child: Icon(Icons.add),
      ),
    );
  }

  ListView getSensorListView() {

    TextStyle titleStyle = Theme.of(context).textTheme.subtitle1;

    return ListView.builder(
      itemCount: filteredSensors.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.keyboard_arrow_right),
            ),

            title: Text(this.filteredSensors[position].unit + " (" + this.filteredSensors[position].sensor + ")", style: titleStyle,),
            subtitle: Text(this.filteredSensors[position].name + ' (' + filteredSensors.length.toString() + ')'),

            onTap: () {
              navigateToDetail(this.filteredSensors[position], "Sensor detail");
            },
          ),
        );
      },
    );
  }

  // Returns the enabled station color
  Color getEnableColor(int enabled) {
    switch (enabled) {
      case 1:
        return Colors.grey;
      case 1:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  // Returns the enabled station color
  Icon getEnabledIcon(int enabled) {
    switch (enabled) {
      case 1:
        return Icon(Icons.vpn_key);
      case 1:
        return Icon(Icons.play_arrow);
      default:
        return Icon(Icons.vpn_key);
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(SensorModule sensor, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SensorDetail(sensor, title);
    }));

    /*if (result == true) {
      updateListView();
    } */
  }

  /*void updateListView(DatabaseHelper db) {
    //Future<List<Sensor>> sensorList = db.getSensorListClosedtoUser(45.5712059, 9.022589, 2000);
    //Future<List<Sensor>> sensorList = db.getSensorList();

    DailyUnitData dud = DailyUnitData();

   //Future<List<Sensor>> sensorList = dud.setSensorsDataAverage(db, 45.8150428, 9.0669, 2000);
    sensorList.then((sensorList) {
      setState(() {
        this.sensorList = sensorList;
        this.count = sensorList.length;
        this.filteredSensors = sensorList;
        print("------------------------ Number of sensors: " + this.count.toString());
      });
    });
  }*/
}


