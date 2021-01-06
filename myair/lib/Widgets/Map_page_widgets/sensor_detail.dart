import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/Sensor.dart';
import 'package:myair/Services/Database_service/DatabaseHelper.dart';
import 'package:myair/Widgets/Map_page_widgets/sensor_data_list.dart';

class SensorDetail extends StatefulWidget {

  final String appBarTitle;
  final SensorModule sensor;

  SensorDetail(this.sensor, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return SensorDetailState(this.sensor, this.appBarTitle);
  }
}

class SensorDetailState extends State<SensorDetail> {

  DatabaseHelper helper = DatabaseHelper();

  final String appBarTitle;
  final SensorModule sensor;

  SensorDetailState(this.sensor, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;

    return Scaffold(
        appBar: AppBar(
          title: Text(sensor.name),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Text(sensor.sensor),
                    Text(sensor.idunit),
                    Text(sensor.unit),
                    Text(sensor.lat),
                    Text(sensor.lng),
                    Text(sensor.name),
                    Text(sensor.uom),
                    Text(sensor.start),
                    //Text(sensor.stop),
                  ],
                )
              ],
            ),
            SizedBox(),
            Row(
              children: [
                FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    navigateToDetail(sensor, "Sensor data");
                  },
                  child: Text(
                    'Sensor data',
                    style: TextStyle(fontSize: 20.0),
                  ),
                )
              ],
            )
          ],
        )
    );

  }

  void navigateToDetail(SensorModule sensor, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SensorDataList(sensor.sensor, title);
    }));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
}