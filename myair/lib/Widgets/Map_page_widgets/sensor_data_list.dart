import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/sensordata.dart';
import 'package:myair/Services/Arpa_service/sensordata.dart';

class SensorDataList extends StatefulWidget {

  final String idSensor;
  final String title;

  SensorDataList(this.idSensor, this.title);

  @override
  State<StatefulWidget> createState() {

    return SensorDataListState(this.idSensor, this.title);
  }
}

class SensorDataListState extends State<SensorDataList> {

  final String idSensore;
  final String title;

  SensorDataListState(this.idSensore, this.title);

  List<SensorData> sensorDataList;
  int count = 0;
  int result;

  @override
  Widget build(BuildContext context) {

    updateListView(this.idSensore);

    return Scaffold(

      appBar: AppBar(
        title: Text(this.title + " - " + this.idSensore),
      ),

      body: getSensorListView(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
        },

        tooltip: 'Add sensor',

        child: Icon(Icons.add),
      ),
    );
  }

  ListView getSensorListView() {

    TextStyle titleStyle = Theme.of(context).textTheme.subtitle1;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.keyboard_arrow_right),
            ),

            title: Text(this.sensorDataList[position].timestamp, style: titleStyle,),
            subtitle: Text(this.sensorDataList[position].value + " (" + count.toString() + ")"),

            onTap: () {
              //navigateToDetail(this.sensorDataList[position], "Sensor detail");
            },
          ),
        );
      },
    );
  }

  void updateListView(String idSensore) {

    Future<List<SensorData>> sensorDataList = fetchSensorDataFromAPI(idSensore,24);
    sensorDataList.then((sensorDataList) {
      setState(() {
        this.sensorDataList = sensorDataList;
        this.count = sensorDataList.length;
        print("------------------------ Number of data sensor: " + this.count.toString());
      });
    });
  }
}

