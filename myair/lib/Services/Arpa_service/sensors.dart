import 'dart:async';
import 'dart:convert'; // parsing json files
import 'package:http/http.dart' as http;
import 'package:myair/Modules/sensor.dart';
import 'package:myair/Modules/unit.dart';
import 'package:myair/Services/Database_service/database_helper.dart';

Future<List<Sensor>> fetchSensorsFromAPI() async {

  DatabaseHelper databaseHelper = DatabaseHelper();

  List<Sensor> sensorList = List<Sensor>();

  // Main thread dedicated to UI
  // We run this function in background using another thread
  // The part after the async is synchronous
  // The part after the wait is asynchronous
  final endpoint = 'https://www.dati.lombardia.it/resource/ib47-atvt.json?\$where=datastop%20is%20NULL';

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
      result = await databaseHelper.insertSensor(sensor);

/*      if (idunit != sensor.idunit) {
        unit = Unit(sensor.unit, sensor.idunit, sensor.lat, sensor.lng);
        result = await databaseHelper.insertUnit(unit);
        idunit = sensor.idunit;
      }

      sensorList.add(Sensor.fromJson(sensorJson)); */
    }

    print("Sensors API finished ...");
  }

  return [];
}
