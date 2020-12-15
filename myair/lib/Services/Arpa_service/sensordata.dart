import 'dart:async';
import 'package:myair/Modules/sensordata.dart';
import 'dart:convert'; // parsing json files
import 'package:http/http.dart' as http;

Future<List<SensorData>> fetchSensorDataFromAPI(String idsensore) async {

  // Main thread dedicated to UI
  // We run this function in background using another thread
  // The part after the async is synchronous
  // The part after the wait is asynchronous
  //final endpoint = 'https://www.dati.lombardia.it/resource/nicp-bhqi.json?idsensore=';
  //final endpoint = 'https://www.dati.lombardia.it/resource/nicp-bhqi.json?';

  final endpoint = 'https://www.dati.lombardia.it/resource/nicp-bhqi.json?';
  // The control is release from the function and other thread can be run
  // When we have the response function can be resumed
  // response is a json object

  var DateTimeFin = DateTime.now();
  var DateTimeIni = DateTime.now().subtract(Duration(hours: 24));

  String DateIni = DateTimeIni.year.toString() + '-' + DateTimeIni.month.toString() + '-' + DateTimeIni.day.toString();
  String DateEnd = DateTimeFin.year.toString() + '-' + DateTimeFin.month.toString() + '-'  + DateTimeFin.day.toString();

  var whereclause = '\$where=%20data%20%3E=%20%27' + DateIni + '%27%20AND%20data%20%3C=%20%27' + DateEnd + '%27%20';
  var sensorclause = '&idsensore=' + idsensore;
  var connectionString = endpoint + whereclause + sensorclause;
  print ('Connection string for data:' + connectionString);

  var response =  await http.get(connectionString);

  if (response.statusCode == 200) {
    List<SensorData> sensorDataList = List<SensorData>();

    var sensorsJson = json.decode(response.body);

    for (var sensorJson in sensorsJson) {

      sensorDataList.add(SensorData.fromJson(sensorJson));
    }

    return sensorDataList;
  }

  return [];
}
