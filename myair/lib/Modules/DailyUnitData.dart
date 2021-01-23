
import 'package:flutter/foundation.dart';
import 'package:myair/Modules/SensorData.dart';
import 'package:myair/Modules/info_pollution.dart';
import 'package:myair/Services/Arpa_service/SensorDataRetriever.dart';
import 'package:myair/Services/Database_service/DatabaseHelper.dart';
import 'package:myair/main.dart';
import 'package:myair/Modules/DailySensorData.dart';
import 'package:myair/Modules/Sensor.dart';
import 'package:myair/Modules/SensorListData.dart';

class DailyUnitData {
  // array last 24h averages
  DailySensorData _pm10;
  DailySensorData _pm25;
  DailySensorData _no2;
  DailySensorData _so2;
  DailySensorData _o3;
  DailySensorData _co;
  //_dailyUnitData instance, we developed it as a Singleton
  static DailyUnitData _dailyUnitData;
  DailyUnitData._createInstance() ;

  //Constructor
  factory DailyUnitData() {
    if (_dailyUnitData == null) {
      // this is execute only once, singleton object
      _dailyUnitData = DailyUnitData._createInstance();
    }
    return _dailyUnitData;
  }
  //Initialization of the arrays
  void initializeValues() {
    _pm10 = DailySensorData();
    _pm25 = DailySensorData();
    _no2 = DailySensorData();
    _so2 = DailySensorData();
    _o3 = DailySensorData();
    _co = DailySensorData();
  }

  //Arrays getters
  ValueListenable<List<double>> getPM10Values() {return _pm10.getValues();}
  ValueListenable<List<double>> getPM25Values() {return _pm25.getValues();}
  ValueListenable<List<double>> getNO2Values() {return _no2.getValues();}
  ValueListenable<List<double>> getSO2Values() {return _so2.getValues();}
  ValueListenable<List<double>> getO3Values() {return _o3.getValues();}
  ValueListenable<List<double>>getCOValues() {return _co.getValues();}

  //Arrays setters of the averages
  void setPM10Values(double data, int hour) {_pm10.setDataAverage(data, hour);}
  void setPM25Values(double data, int hour) {_pm25.setDataAverage(data, hour);}
  void setNO2Values(double data, int hour) {_no2.setDataAverage(data, hour);}
  void setSO2Values(double data, int hour) {_so2.setDataAverage(data, hour);}
  void setO3Values(double data, int hour) {_o3.setDataAverage(data, hour);}
  void setCOValues(double data, int hour) {_co.setDataAverage(data, hour);}

  //In this function we takes all the sensors sorted based on the distance from the user
  //And for each pollutant agents we make an API call to the databases of the ARPA
  Future<void> setSensorsDataAverage(DatabaseHelper db, int hour, double ulat, double ulong, int utol) async {
    //Checkers if we already found a sensor for this specific agent
    bool bpm10 = false;
    bool bpm25 = false;
    bool bno2 = false;
    bool bso2 = false;
    bool bo3 = false;
    bool co = false;

    SensorModule sensor;
    double average;

    //Get All the sensor in the database
    List<SensorModule> slAll = await db.getSensorList();
    //Get all the sensor in a predefined area utol equals to 50Km
    List<SensorModule> sensorList = await getSensorListClosedtoUser(slAll, ulat, ulong, utol);

    //Cycle on all the sensors in order to get the value for all the agents
    for (sensor in sensorList) {

      if ((sensor.name.contains("PM10")) && (bpm10 == false)) {
        //Get values by the sensor
        var dataSensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        //Check if there are available values in this week
        if (dataSensor.length > 0){
          //It makes a weighted average
          average = actualAverage(dataSensor);
          //Set the average of this [hour] in the array
          this._pm10.setDataAverage(average, hour);
          //Agent founded
          bpm10 = true;
          //Set the array that contains the last measured value
          kInfo.value.elementAt(0).value = new InfoPollution("PM10", amount: average);
        }
      }

      if ((sensor.name.contains("PM2.5")) && (bpm25 == false)) {
        //Get values by the sensor
        var dataSensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        //Check if there are available values in this week
        if (dataSensor.length > 0){
          //It makes a weighted average
          average = actualAverage(dataSensor);
          //Set the average of this [hour] in the array
          this._pm25.setDataAverage(average, hour);
          //Agent founded
          bpm25 = true;
          //Set the array that contains the last measured value
          kInfo.value.elementAt(1).value = new InfoPollution("PM2.5", amount: average);
        }
      }

      if ((sensor.name.contains("Biossido di Azoto")) && (bno2 == false)) {
        //Get values by the sensor
        var dataSensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        //Check if there are available values in this week
        if (dataSensor.length > 0){
          //It makes a weighted average
          average = actualAverage(dataSensor);
          //Set the average of this [hour] in the array
          this._no2.setDataAverage(average, hour);
          //Agent founded
          bno2 = true;
          //Set the array that contains the last measured value
          kInfo.value.elementAt(2).value = new InfoPollution("NO2", amount: average);
        }
      }

      if ((sensor.name.contains("Zolfo")) && (bso2 == false)) {
        //Get values by the sensor
        var dataSensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        //Check if there are available values in this week
        if (dataSensor.length > 0){
          //It makes a weighted average
          average = actualAverage(dataSensor);
          //Set the average of this [hour] in the array
          this._so2.setDataAverage(average, hour);
          //Agent founded
          bso2 = true;
          //Set the array that contains the last measured value
          kInfo.value.elementAt(3).value = new InfoPollution("SO2", amount: average);
        }
      }

      if ((sensor.name.contains("Ozono")) && (bo3 == false)) {
        //Get values by the sensor
        var dataSensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        //Check if there are available values in this week
        if (dataSensor.length > 0){
          //It makes a weighted average
          average = actualAverage(dataSensor);
          //Set the average of this [hour] in the array
          this._o3.setDataAverage(average, hour);
          //Agent founded
          bo3 = true;
          //Set the array that contains the last measured value
          kInfo.value.elementAt(4).value = new InfoPollution("O3", amount: average);
        }
      }

      if ((sensor.name.contains("Monossido di Carbonio")) && (co == false)) {
        //Get values by the sensor
        var dataSensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        //Check if there are available values in this week
        if (dataSensor.length > 0){
          //It makes a weighted average
          average = actualAverage(dataSensor);
          //Set the average of this [hour] in the array
          this._co.setDataAverage(average, hour);
          //Agent founded
          co = true;
          //Set the array that contains the last measured value
          kInfo.value.elementAt(5).value = new InfoPollution("CO", amount: average);
        }
      }
      //Check if we take all the values
      if ( bpm10 && bpm25 && bno2 && bso2 && bo3 && co) {break;}
    }
  }
}

// Average calculation for the data retrieved for a sensor
double actualAverage(List<SensorData> data_sensor){

  double weightLast = 3.0;
  double weightHour = 3.0;
  double weightNorm = 1.0;

  double actualValue = 0.0;
  int weight = 0;
  var hourFromAPI;

  // Cycle on the data related to the selected sensor
  for(var index = 0; index < data_sensor.length; index ++) {
    if (index == 24) break;
    // The timestamp hour is the same of the current hour
    hourFromAPI = DateTime.parse(data_sensor.elementAt(index).timestamp).hour;
    if (DateTime.now().hour == hourFromAPI) {
      actualValue += (double.parse(data_sensor.elementAt(index).value) * weightHour);
      weight += 2;
    }
    // Most recent value
    else if (index == 0) {
      actualValue += (double.parse(data_sensor.elementAt(index).value) * weightLast);
    }
    else {
      actualValue += double.parse(data_sensor.elementAt(index).value) * weightNorm;
    }
  }
  // Average of the data related to a sensor
  actualValue = actualValue/(data_sensor.length + weight + 2);
  return actualValue;
}
