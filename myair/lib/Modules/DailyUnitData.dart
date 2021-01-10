
import 'package:flutter/foundation.dart';
import 'package:myair/Modules/SensorData.dart';
import 'package:myair/Modules/info_pollution.dart';
import 'package:myair/Services/Arpa_service/SensorDataRetriever.dart';
import 'package:myair/Services/Database_service/DatabaseHelper.dart';
import '../main.dart';
import 'DailySensorData.dart';
import 'package:myair/Modules/Sensor.dart';
import 'InstantData.dart';
import 'package:myair/Modules/SensorListData.dart';

class DailyUnitData {

  DailySensorData _pm10; /// array ultime 24h  di misurazione
  DailySensorData _pm25;
  DailySensorData _no2;
  DailySensorData _so2;
  DailySensorData _o3;
  DailySensorData _co;
  static DailyUnitData _dailyUnitData;
  DailyUnitData._createInstance() ;

  factory DailyUnitData() {

    if (_dailyUnitData == null) {
      _dailyUnitData = DailyUnitData._createInstance();
      // this is execute only once, singleton object
    }
    return _dailyUnitData;
  }
  void initializeValues() {
    _pm10 = DailySensorData();
    _pm25 = DailySensorData();
    _no2 = DailySensorData();
    _so2 = DailySensorData();
    _o3 = DailySensorData();
    _co = DailySensorData();
  }

  ValueListenable<List<double>> getPM10Values() {
    return _pm10.getValues();
  }

  ValueListenable<List<double>> getPM25Values() {
    return _pm25.getValues();
  }

  ValueListenable<List<double>> getNO2Values() {
    return _no2.getValues();
  }

  ValueListenable<List<double>> getSO2Values() {
    return _so2.getValues();
  }

  ValueListenable<List<double>> getO3Values() {
    return _o3.getValues();
  }

  ValueListenable<List<double>>getCOValues() {
    return _co.getValues();
  }

  Future<List<InstantData>> setSensorsDataAverage(DatabaseHelper db, int hour, double ulat, double ulong, int utol) async {
    bool bpm10 = false;
    bool bpm25 = false;
    bool bno2 = false;
    bool bso2 = false;
    bool bo3 = false;
    bool co = false;

    SensorModule sensor;
    double average;

    List<SensorModule> slAll = await db.getSensorList();
    List<SensorModule> sensorList = await getSensorListClosedtoUser(slAll, ulat, ulong, utol);
    List<InstantData> sensorData = [];

    for (sensor in sensorList) {

      if ((sensor.name.contains("PM10")) && (bpm10 == false)) {
        var data_sensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        if (data_sensor.length > 0){
          average = actualAverage(data_sensor);
          this._pm10.setDataAverage(average, hour);///Media dell'ora attuale nella posizione [hour] dell'array

          bpm10 = true;

         //kInfo.elementAt(0).amount = average;
          kInfo.value.elementAt(0).value = new InfoPollution("PM10", amount: average);
          // Data structure for real time data dispaly
          InstantData d = new InstantData(sensor.sensor, "PM10", average.toString(), data_sensor.elementAt(data_sensor.length-1).timestamp,sensor.name);
          sensorData.add(d);
        }
      }

      if ((sensor.name.contains("PM2.5")) && (bpm25 == false)) {
        var data_sensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        if (data_sensor.length > 0){
          average = actualAverage(data_sensor);
          await this._pm25.setDataAverage(average, hour);

          bpm25 = true;

          kInfo.value.elementAt(1).value = new InfoPollution("PM2.5", amount: average);
          print( kInfo.value.elementAt(1).value.amount);
          InstantData d = new InstantData(sensor.sensor, "PM2.5", average.toString(), data_sensor.elementAt(data_sensor.length-1).timestamp,sensor.name);
          sensorData.add(d);
        }
      }

      if ((sensor.name.contains("Biossido di Azoto")) && (bno2 == false)) {
        var data_sensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        if (data_sensor.length > 0){
          average = actualAverage(data_sensor);
          await this._no2.setDataAverage(average, hour);

          bno2 = true;

          kInfo.value.elementAt(2).value = new InfoPollution("NO2", amount: average);
          InstantData d = new InstantData(sensor.sensor, "NO2", average.toString(), data_sensor.elementAt(data_sensor.length-1).timestamp,sensor.name);
          sensorData.add(d);
        }
      }

      if ((sensor.name.contains("Zolfo")) && (bso2 == false)) {
        var data_sensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        if (data_sensor.length > 0){
          average = actualAverage(data_sensor);
          await this._so2.setDataAverage(average, hour);

          bso2 = true;

          kInfo.value.elementAt(3).value = new InfoPollution("SO2", amount: average);
          InstantData d = new InstantData(sensor.sensor, "SO2", average.toString(), data_sensor.elementAt(data_sensor.length-1).timestamp,sensor.name);
          sensorData.add(d);
        }
      }

      if ((sensor.name.contains("Ozono")) && (bo3 == false)) {
        var data_sensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        if (data_sensor.length > 0){
          average = actualAverage(data_sensor);
          await this._o3.setDataAverage(average, hour);

          bo3 = true;

          kInfo.value.elementAt(4).value = new InfoPollution("O3", amount: average);
          InstantData d = new InstantData(sensor.sensor, "O3", average.toString(), data_sensor.elementAt(data_sensor.length-1).timestamp,sensor.name);
          sensorData.add(d);
        }
      }

      if ((sensor.name.contains("Monossido di Carbonio")) && (co == false)) {
        var data_sensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        if (data_sensor.length > 0){
          average = actualAverage(data_sensor);
          await this._co.setDataAverage(average, hour);

          co = true;

          kInfo.value.elementAt(5).value = new InfoPollution("CO", amount: average);
          InstantData d = new InstantData(sensor.sensor, "CO", average.toString(), data_sensor.elementAt(data_sensor.length-1).timestamp,sensor.name);
          sensorData.add(d);
        }
      }

      if ( bpm10 && bpm25 && bno2 && bso2 && bo3) {
        //TODO set 0 to value not found
        break;
      }

    }

    return sensorData;
  }


}

// Average calculation for the data retrieved for a sensor
double actualAverage(List<SensorData> data_sensor){

  double weight_last = 3.0;
  double weight_hour = 3.0;
  double weight_norm = 1.0;

  double actualvalue = 0.0;
  int weight = 0;
  var hourfromapi;

  // Cycle on the data related to the selected sensor
  for(var index = 0; index < data_sensor.length; index ++) {
    if (index == 24) break;

    // The timestamp hour is the same of the current hour
    hourfromapi = DateTime.parse(data_sensor.elementAt(index).timestamp).hour;
    if (DateTime.now().hour == hourfromapi) {
      actualvalue += (double.parse(data_sensor.elementAt(index).value) * weight_hour);
      weight += 2;
    }
    // Most recent value
    else if (index == 0) {
      actualvalue += (double.parse(data_sensor.elementAt(index).value) * weight_last);
    }
    else {
      actualvalue += double.parse(data_sensor.elementAt(index).value) * weight_norm;
    }
  }

  // Average of the data related to a sensor
  actualvalue = actualvalue/(data_sensor.length + weight + 2);

  return actualvalue;
}
