
import 'package:myair/Modules/sensordata.dart';
import 'package:myair/Services/Arpa_service/sensordata.dart';
import 'package:myair/Services/Database_service/database_helper.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/pie_chart.dart';
import 'DailySensorData.dart';
import 'package:myair/Modules/sensor.dart';

import 'InstantData.dart';

class DailyUnitData {

  DailySensorData _pm10;
  DailySensorData _pm25;
  DailySensorData _no2;
  DailySensorData _so2;
  DailySensorData _o3;

  double weight_last;
  double weight_day;
  double weight_norm;

  DailyUnitData() {
    _pm10 = DailySensorData();
    _pm25 = DailySensorData();
    _no2 = DailySensorData();
    _so2 = DailySensorData();
    _o3 = DailySensorData();

    weight_last = 3;
    weight_day = 3;
    weight_norm = 1;
  }

  List<double> getPM10Values() {
    return _pm10.getValues();
  }

  List<double> getPM25Values() {
    return _pm25.getValues();
  }

  List<double> getNO2Values() {
    return _no2.getValues();
  }

  List<double> getSO2Values() {
    return _so2.getValues();
  }

  List<double> getO3Values() {
    return _o3.getValues();
  }

  Future<List<InstantData>> setSensorsDataAverage(DatabaseHelper db, double ulat, double ulong, int utol) async {
    bool bpm10 = false;
    bool bpm25 = false;
    bool bno2 = false;
    bool bso2 = false;
    bool bo3 = false;
  //TODO make a weighted value
    Sensor sensor;
    double average;
    List<Sensor> sensorList = await db.getSensorListClosedtoUser(ulat, ulong, utol);
    List<InstantData> sensorData = [];

    for (sensor in sensorList) {

      if ((sensor.name.contains("PM10")) && (bpm10 == false)) {
        var data_sensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        if (data_sensor.length > 0){
         // average = await this._pm10.setDataAverage(sensor.sensor);
          var value = actualAverage(data_sensor);
          print("----------------------------------------------------------Average: " + average.toString() + " Value: " + value.toString());
          bpm10 = true;
          kInfo.elementAt(0).amount = value;
          InstantData d = new InstantData(sensor.sensor, "PM10", value.toString(), data_sensor.elementAt(data_sensor.length-1).timestamp,sensor.name);
          sensorData.add(d);
        }


      }

      if ((sensor.name.contains("PM2.5")) && (bpm25 == false)) {
        var data_sensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        if (data_sensor.length > 0){
         // average = await this._pm25.setDataAverage(sensor.sensor);
          bpm25 = true;
          var value = actualAverage(data_sensor);
          kInfo.elementAt(1).amount = value;
          InstantData d = new InstantData(sensor.sensor, "PM2.5", value.toString(), data_sensor.elementAt(data_sensor.length-1).timestamp,sensor.name);
          sensorData.add(d);
        }
      }

      if ((sensor.name.contains("Biossido di Azoto")) && (bno2 == false)) {

        var data_sensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        if (data_sensor.length > 0){
       //   average = await this._no2.setDataAverage(sensor.sensor);
          bno2 = true;  var value = actualAverage(data_sensor);
          kInfo.elementAt(2).amount = value;
          InstantData d = new InstantData(sensor.sensor, "NO2", value.toString(), data_sensor.elementAt(data_sensor.length-1).timestamp,sensor.name);
          sensorData.add(d);
        }
      }

      if ((sensor.name.contains("Zolfo")) && (bso2 == false)) {

        var data_sensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        if (data_sensor.length > 0){
        //  average = await this._so2.setDataAverage(sensor.sensor);
          bso2 = true;
          var value = actualAverage(data_sensor);
          kInfo.elementAt(3).amount = value;
          InstantData d = new InstantData(sensor.sensor, "SO2", value.toString(), data_sensor.elementAt(data_sensor.length-1).timestamp,sensor.name);
          sensorData.add(d);
        }

      }

      if ((sensor.name.contains("Ozono")) && (bo3 == false)) {

        var data_sensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        if (data_sensor.length > 0){
       //   average = await this._o3.setDataAverage(sensor.sensor);
          var value = actualAverage(data_sensor);
          kInfo.elementAt(4).amount = value;
          kInfo.elementAt(5).amount = value;
          InstantData d = new InstantData(sensor.sensor, "O3", value.toString(), data_sensor.elementAt(data_sensor.length-1).timestamp,sensor.name);
          sensorData.add(d);
          bo3 = true;
        }


      }

      if ( bpm10 && bpm25 && bno2 && bso2 && bo3) {
        break;
      }

    }
    return sensorData;
  }
}

// Average calculation for the data retrieved for a sensor
double actualAverage(List<SensorData> data_sensor){
  print("Number of data from sensor: "  + data_sensor.length.toString());

  double actualvalue = 0.0;
  int weight = 0;
  var hourfromapi;

  // Cycle on the data related to the selected sensor
  for(var index = 0; index < data_sensor.length; index ++) {
    if (index == 24) break;

    // The timestamp hour is the same of the current hour
    hourfromapi = DateTime.parse(data_sensor.elementAt(index).timestamp).hour;
    if (DateTime.now().hour == hourfromapi) {
      actualvalue += (double.parse(data_sensor.elementAt(index).value) * 3.0);
      weight += 2;
    }
    // Most recent value
    else if (index == 0) {
      actualvalue += (double.parse(data_sensor.elementAt(index).value) * 3.0 );
    }
    else {
      actualvalue += double.parse(data_sensor.elementAt(index).value);
    }
  }

  // Average of the data related to a sensor
  actualvalue = actualvalue/(data_sensor.length + weight + 2);

  return actualvalue;
}
