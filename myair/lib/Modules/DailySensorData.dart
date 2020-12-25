
import 'package:myair/Modules/sensordata.dart';
import 'package:myair/Services/Arpa_service/sensordata.dart';

class DailySensorData {

  List<double> _values = [];
  double weight_last;
  double weight_day;
  double weight_norm;

  DailySensorData() {
    for (var i =0; i < 24; i++) {
      this._values.add(0);
    }

    this.weight_last = 6/24;
    this.weight_day = 6/24;
    this.weight_norm = 12/24;

    print("Costruttore DailySensorData");
  }

  List<double> getValues() {
    return _values;
  }

  Future<double> setDataAverage(String idSensore) async {
    List<SensorData> sensorDataList = List<SensorData>();

    double average = 0;
    double weight = 0;

    int currenthour = DateTime.now().hour;
    var hourfromapi;
    var day;

    //sensorDataList = await fetchSensorDataFromAPI(idSensore,24);
    sensorDataList.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    for (var i = 0; i < sensorDataList.length; i++) {
      hourfromapi = DateTime.parse(sensorDataList[0].timestamp).hour;

      if (hourfromapi == currenthour) {
        weight = this.weight_day;
      } else if (i == 24) {
        weight = this.weight_last;
      } else {
        weight = weight_norm;
      }

      average = average + (double.parse(sensorDataList[0].value) * weight);
    }

    if (sensorDataList.length > 0) {
      average = average / sensorDataList.length;
    }

    if (sensorDataList.length != 24) {
      print("Il numero dei dati per il calcolo della media deve essere 24 !");
    }

    this._values[DateTime.now().hour] = (this._values[DateTime.now().hour] + average) / 2;
   // print("Calcolo media: " +  _values[DateTime.now().day].toString());

    return average;
  }

}

