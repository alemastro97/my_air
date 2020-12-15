import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/sensor.dart';
import 'package:myair/Modules/unit.dart';

class UnitList extends StatefulWidget {

  final List<Sensor> sensorList;
  final String title;

  UnitList(this.sensorList, this.title);

  @override
  State<StatefulWidget> createState() {

    return UnitListState(sensorList, title);
  }
}

class UnitListState extends State<UnitList> {

  final List<Sensor> sensorList;
  final String title;

  UnitListState(this.sensorList, this.title);

  List<Unit> unitList;
  int count = 0;
  int result;

  @override
  Widget build(BuildContext context) {

    if (unitList == null) {
        updateListView(this.sensorList);
    }

    return Scaffold(

      appBar: AppBar(
        title: Text(this.title),
      ),

      body: getSensorListView(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
        },

        tooltip: 'TBD',

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

            title: Text(this.unitList[position].idunit, style: titleStyle,),
            subtitle: Text(this.unitList[position].unit + " (" + count.toString() + ")"),

            onTap: () {
              //navigateToDetail(this.sensorDataList[position], "Sensor detail");
            },
          ),
        );
      },
    );
  }

  void updateListView(List<Sensor> sensor) {
    Future<List<Unit>> viewList = getUnitList(sensor);

    viewList.then((viewList) {
      setState(() {
        this.unitList = viewList;
        this.count = viewList.length;

        print("------------------------ Number of units: " + this.count.toString());
      });
    });
  }
}

getUnitList(List<Sensor> sensor)  {
  var idunit = "";
  List<Unit> unitList = List();
  Unit unit;

  for (var sensoritem in sensor) {

    if (idunit != sensoritem.idunit) {
      unit = new Unit(sensoritem.id, sensoritem.unit, sensoritem.idunit, double.parse(sensoritem.lat),double.parse( sensoritem.lng));
      unitList.add(unit);
    }

    idunit = unit.idunit;
  }

  return unitList;
  print("Unit list loaded (" + unitList.length.toString() + ")");
}

