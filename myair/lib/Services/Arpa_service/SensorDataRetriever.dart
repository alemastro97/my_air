import 'dart:async';
import 'dart:convert'; // parsing json files
import 'package:http/http.dart' as http;
import 'package:myair/Modules/SensorData.dart';

Future<List<SensorData>> fetchSensorDataFromAPI(String idsensore,int duration) async {
  if(duration > 168) return [];
  // Main thread dedicated to UI
  // We run this function in background using another thread
  // The part after the async is synchronous
  // The part after the wait is asynchronous
  //final endpoint = 'https://www.dati.lombardia.it/resource/nicp-bhqi.json?idsensore=';
  //final endpoint = 'https://www.dati.lombardia.it/resource/nicp-bhqi.json?';
  print(idsensore);
  final endpoint = 'https://www.dati.lombardia.it/resource/nicp-bhqi.json?';
  // The control is release from the function and other thread can be run
  // When we have the response function can be resumed
  // response is a json object

  var DateTimeFin = DateTime.now();
  var DateTimeIni = DateTime.now().subtract(Duration(hours: duration));

  String DateIni = DateTimeIni.year.toString() + '-' + DateTimeIni.month.toString() + '-' + DateTimeIni.day.toString();
  String DateEnd = DateTimeFin.year.toString() + '-' + DateTimeFin.month.toString() + '-'  + DateTimeFin.day.toString();

  var whereclause = '\$where=%20data%20%3E=%20%27' + DateIni + '%27%20AND%20data%20%3C=%20%27' + DateEnd + '%27%20';
  var sensorclause = '&idsensore=' + idsensore;
  var validationclause = '&stato=%27VA%27&\$order=data%20DESC';
  var connectionString = endpoint + whereclause + sensorclause + validationclause;
  print ('Connection string for data:' + connectionString);

  var response =  await http.get(connectionString);

  if (response.statusCode == 200) {
    List<SensorData> sensorDataList = List<SensorData>();

    var sensorsJson = json.decode(response.body);

    for (var sensorJson in sensorsJson) {

      sensorDataList.add(SensorData.fromJson(sensorJson));
    }
    //if (sensorDataList.length == 0)  sensorDataList =   await fetchSensorDataFromAPI(idsensore,duration + 24);
    if (sensorDataList.length < 24) {
      var x = await fetchSensorDataFromAPI(idsensore, duration + 24);
      x.length != 0 ? sensorDataList = x : null;
    }
    return sensorDataList;
  }

  return [];
}
