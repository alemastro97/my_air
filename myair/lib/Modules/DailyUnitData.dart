
import 'package:myair/Services/Database_service/database_helper.dart';
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

  Future<List<Sensor>> setSensorsDataAverage(DatabaseHelper db, double ulat, double ulong, int utol) async {
    bool bpm10 = false;
    bool bpm25 = false;
    bool bno2 = false;
    bool bso2 = false;
    bool bo3 = false;

    Sensor sensor;
    double average;

    List<Sensor> sensorList = await db.getSensorListClosedtoUser(ulat, ulong, utol);
    List<Sensor> sensorListUseful = [];

    for (sensor in sensorList) {

      if ((sensor.name.contains("PM10")) && (bpm10 == false)) {
        average = await this._pm10.setDataAverage(sensor.sensor);

        if (sensor.stop == null) {
          bpm10 = true;
          sensorListUseful.add(sensor);
       }
      }

      if ((sensor.name.contains("PM2.5")) && (bpm25 == false)) {
        average = await this._pm25.setDataAverage(sensor.sensor);

        if (sensor.stop == null) {
          bpm25 = true;
          sensorListUseful.add(sensor);
        }
      }

      if ((sensor.name.contains("Azoto")) && (bno2 == false)) {
        average = await this._no2.setDataAverage(sensor.sensor);

       if (sensor.stop == null) {
          bno2 = true;
          sensorListUseful.add(sensor);
      }
      }

      if ((sensor.name.contains("Zolfo")) && (bso2 == false)) {
        average = await this._so2.setDataAverage(sensor.sensor);

        if (sensor.stop == null) {
          bso2 = true;
          sensorListUseful.add(sensor);
        }
      }

      if ((sensor.name.contains("Ozono")) && (bo3 == false)) {
        average = await this._o3.setDataAverage(sensor.sensor);

       if (sensor.stop == null) {
          bo3 = true;
          sensorListUseful.add(sensor);
       }
      }

      if ( bpm10 && bpm25 && bno2 && bso2 && bo3) {
        break;
      }

    }
    print("sjsjssjjsjsjsjsjsjsjsjsjsjjs" + sensorListUseful.length.toString());
    return sensorListUseful;
  }
}

