import 'dart:async';
import 'dart:convert'; // parsing json files
import 'package:http/http.dart' as http;
import 'package:myair/Modules/Sensor.dart';
import 'package:myair/Services/Database_service/DatabaseHelper.dart';

Future<void> fetchSensorsFromAPI() async {
  SensorModule sensor;
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

  print("Sensors API checking ...");
  if (response.statusCode == 200) {
    var sensorsJson = json.decode(response.body);
    print("Sensors API loading ...");
    for (var sensorJson in sensorsJson) {
      sensor = SensorModule.fromJson(sensorJson);
      await DatabaseHelper().insertSensor(sensor);
    }
  }
  print("Sensors API finished ...");
}

