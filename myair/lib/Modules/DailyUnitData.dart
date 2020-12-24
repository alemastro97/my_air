
import 'package:myair/Modules/sensordata.dart';
import 'package:myair/Services/Arpa_service/sensordata.dart';
import 'package:myair/Services/Database_service/database_helper.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/pie_chart.dart';
import 'DailySensorData.dart';
import 'package:myair/Modules/sensor.dart';

class DailyUnitData {

  DailySensorData _pm10;
  DailySensorData _pm25;
  DailySensorData _no2;
  DailySensorData _so2;
  DailySensorData _o3;

  DailyUnitData() {
    _pm10 = DailySensorData();
    _pm25 = DailySensorData();
    _no2 = DailySensorData();
    _so2 = DailySensorData();
    _o3 = DailySensorData();

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

  Future<List<SensorData>> setSensorsDataAverage(DatabaseHelper db, double ulat, double ulong, int utol) async {
    bool bpm10 = false;
    bool bpm25 = false;
    bool bno2 = false;
    bool bso2 = false;
    bool bo3 = false;

    Sensor sensor;
    double average;

    List<Sensor> sensorList = await db.getSensorListClosedtoUser(ulat, ulong, utol);
    List<SensorData> sensorData = [];

    for (sensor in sensorList) {

      if ((sensor.name.contains("PM10")) && (bpm10 == false)) {
        var data_sensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        if (data_sensor.length > 0){
          average = await this._pm10.setDataAverage(sensor.sensor);
          bpm10 = true;
          print("PM10----------------------------------------------------------------------------------");
          sensorData.add(data_sensor.elementAt(data_sensor.length-1));
        }


      }

      if ((sensor.name.contains("PM2.5")) && (bpm25 == false)) {
        var data_sensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        if (data_sensor.length > 0){
          average = await this._pm25.setDataAverage(sensor.sensor);
          bpm25 = true;
          print("PM25----------------------------------------------------------------------------------");

          sensorData.add(data_sensor.elementAt(data_sensor.length-1));
        }
      }

      if ((sensor.name.contains("Biossido di Azoto")) && (bno2 == false)) {

        var data_sensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        if (data_sensor.length > 0){
          average = await this._no2.setDataAverage(sensor.sensor);
          bno2 = true;
          print("Azoto----------------------------------------------------------------------------------");

          sensorData.add(data_sensor.elementAt(data_sensor.length-1));
        }
      }

      if ((sensor.name.contains("Zolfo")) && (bso2 == false)) {

        var data_sensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        if (data_sensor.length > 0){
          average = await this._so2.setDataAverage(sensor.sensor);
          bso2 = true;
          print("Zolfo----------------------------------------------------------------------------------");

          sensorData.add(data_sensor.elementAt(data_sensor.length-1));
        }

      }

      if ((sensor.name.contains("Ozono")) && (bo3 == false)) {

        var data_sensor = await fetchSensorDataFromAPI(sensor.sensor,24);
        if (data_sensor.length > 0){
          average = await this._o3.setDataAverage(sensor.sensor);
          print("Ozono----------------------------------------------------------------------------------");

          bo3 = true;
          sensorData.add(data_sensor.elementAt(data_sensor.length-1));
        }


      }

      if ( bpm10 && bpm25 && bno2 && bso2 && bo3) {
        break;
      }

    }
   //print("sjsjssjjsjsjsjsjsjsjsjsjsjjs" + sensorListUseful.length.toString());
    return sensorData;
  }
}

