import 'package:flutter_test/flutter_test.dart';
import 'package:myair/Modules/sensordata.dart';
import 'package:myair/Modules/DailyUnitData.dart';


void main() {
  group('Average related to a sensor -', () {

    // 24 equal values, no hour = actual hour
    test('24 equals values, no hour = actual hour ', () {
      List<SensorData> data_sensor = [];
      SensorData sensordata;

      sensordata = new SensorData(1,'sensor01','2020-12-26T00:00:00,000','0.84','state1', 'operator1');
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
      sensordata1 = new SensorData(1,'sensor01','2020-12-26T01:00:00,000','0.84','state1', 'operator1');
      sensordata2 = new SensorData(1,'sensor01','2020-12-26T19:00:00,000','0.78','state1', 'operator1');

      for (int i = 0; i < 24; i++) {
        if (i == 4) {
          data_sensor.add(sensordata2);
        }
        else {
          data_sensor.add(sensordata1);
        }
      }

      double result = actualAverage(data_sensor);

      expect(result, 0.8335714285714285);
    });

  });
}
