import 'package:flutter_test/flutter_test.dart';
import 'package:myair/Modules/DailySensorData.dart';
import 'package:myair/Modules/InstantData.dart';
import 'package:myair/Modules/sensor.dart';
import 'package:myair/Modules/sensordata.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Services/Arpa_service/sensors.dart';
import 'package:myair/Services/Database_service/database_helper.dart';


void main() {

  TestWidgetsFlutterBinding.ensureInitialized();

  group('Average related to a sensor -', () {
    // 24 equal values, no hour = actual hour
    test('24 equals values, no hour = actual hour ', () {
      List<SensorData> data_sensor = [];
      SensorData sensordata;

      sensordata = new SensorData(
          1, 'sensor01', '2020-12-26T00:00:00,000', '0.84', 'state1',
          'operator1');
      for (int i = 0; i < 24; i++) {
        data_sensor.add(sensordata);
      }

      double result = actualAverage(data_sensor);
      print('Result: ' + result.toString());

      expect(result, 0.84);
    });

    // 24 equal values, one hour = actual hour
    // Set sensordata2 hour to the actual hour in order to run correctly the test
    test('24 equals values, no hour = actual hour ', () {
      List<SensorData> data_sensor = [];
      SensorData sensordata1, sensordata2;
      sensordata1 = new SensorData(
          1, 'sensor01', '2020-12-26T01:00:00,000', '0.84', 'state1',
          'operator1');
      sensordata2 = new SensorData(
          1, 'sensor01', '2020-12-26T19:00:00,000', '0.78', 'state1',
          'operator1');

      for (int i = 0; i < 24; i++) {
        if (i == 4) {
          data_sensor.add(sensordata2);
        }
        else {
          data_sensor.add(sensordata1);
        }
      }

      double result = actualAverage(data_sensor);

      expect(result, 0.8376923076923076);
    });

    // Average calculus
    test('Average calculus', () {
      double sensor_value = 0.78;
      int hour = DateTime
          .now()
          .hour;

      DailySensorData st = DailySensorData();

      for (int i = 0; i < 10; i++) {
        st.setDataAverage(sensor_value, hour);

        print(st.getValues());
      }

      List<double> values = st.getValues();

      expect((values[hour] * 1000).round() / 1000, 0.779);
    });

    // Save the average in the right position of the Sensor data array
    test('Average in the right position', () {
      double average = 0.5;

      DailySensorData st = DailySensorData();

      for (int i = 0; i < 24; i++) {
        st.setDataAverage(average, i);

        average = average + 0.1;
      }

      expect((st.getSum() * 10).round() / 10, 19.8);
    });

    // Save the average in the right position of the Sensor data array
    test('Sensors close to the user', () async {

      double ulat = 45.81504286011291;
      double ulong = 9.06697137484454;
      int utol = 10;

      DatabaseHelper db = DatabaseHelper();

      Sensor sensor;
      List<Sensor> sensorList;

      sensorList = await db.getSensorList();
      if(sensorList.length == 0){
        await fetchSensorsFromAPI();
        sensorList = await db.getSensorList();
      }

      sensorList = await db.getSensorListClosedtoUser(ulat, ulong, utol);

    });

    // Save the average in the right position of the Sensor data array
    test('Sensors close to the user', () {
      double ulat = 45.81504286011291;
      double ulong = 9.06697137484454;
      int utol = 10000;

      DailyUnitData d = new DailyUnitData();
      DatabaseHelper db = new DatabaseHelper();

      Future<List<InstantData>> sensorData = d.setSensorsDataAverage(db, DateTime.now().hour, ulat, ulong, utol);

      print(d.getCOValues());
      print(d.getNO2Values());
      print(d.getO3Values());
      print(d.getPM10Values());
      print(d.getPM25Values());
      print(d.getSO2Values());
    });
  });
}
