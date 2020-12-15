import 'dart:async';
import 'package:myair/Modules/sensor.dart';
import 'package:myair/Modules/unit.dart';
import 'package:myair/Services/Database_service/database_helper.dart';
import 'dart:convert'; // parsing json files
import 'package:http/http.dart' as http;

Future<void> fetchSensorsFromAPI() async {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Sensor> sensorList = List<Sensor>();
  // Main thread dedicated to UI
  // We run this function in background using another thread
  // The part after the async is synchronous
  // The part after the wait is asynchronous
  final endpoint = 'https://www.dati.lombardia.it/resource/ib47-atvt.json';

  // The control is release from the function and other thread can be run
  // When we have the response function can be resumed
  // response is a json object
  var connectionString = endpoint;
  var response =  await http.get(connectionString);

  int result;

  String idunit = "";
  Sensor sensor;
  Unit unit;

  print("Sensors API checking ...");

  if (response.statusCode == 200) {
    var sensorsJson = json.decode(response.body);
    print("Sensors API loading ...");

    for (var sensorJson in sensorsJson) {

      sensor = Sensor.fromJson(sensorJson);
      print("" + sensor.toString());
      result = await databaseHelper.insertSensor(sensor);

     // sensorList.add(Sensor.fromJson(sensorJson));
    }

    print("Sensors API finished ...");
  }
}
