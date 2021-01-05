import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myair/Modules/DailySensorData.dart';
import 'package:myair/Modules/PollutantAgent.dart';
import 'package:myair/Modules/SensorListData.dart';
import 'package:myair/Modules/sensor.dart';
import 'package:myair/Modules/sensordata.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Services/Database_service/database_helper.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  group('Sensor data checking -', () {
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
      double ulat = 45.443857653564926;
      double ulong = 9.167944501742676;
      int utol = 10000;

      Sensor sensor;
      Sensor sensor1 = Sensor(
          121,
          "5718",
          "Magenta",
          "546",
          "45.462415791106615",
          "8.880210433125571",
          "Ozono",
          "µg/m³",
          "1995-07-29T00:00:00.000",
          null);
      Sensor sensor2 = Sensor(
          464,
          "5823",
          "Milano - viale Liguria",
          "539",
          "45.443857653564926",
          "9.167944501742676",
          "Monossido di Carbonio",
          "mg/m³",
          "1991-10-20T00:00:00.000",
          null);
      Sensor sensor3 = Sensor(
          24,
          "6328",
          "Milano - viale Marche",
          "501",
          "45.49631644365102",
          "9.190933555313624",
          "Ossidi di Azoto",
          "µg/m³",
          "1980-09-18T00:00:00.000",
          null);
      Sensor sensor4 = Sensor(
          90,
          "10458",
          "Bertonico",
          "1266",
          "45.23349364130374",
          "9.666250375296032",
          "Biossido di Azoto",
          "µg/m³",
          "2009-08-03T00:00:00.000",
          null);
      Sensor sensor5 = Sensor(
          81,
          "10437",
          "Sondrio - via Paribelli",
          "1264",
          "46.167852440665115",
          "9.879209924469903",
          "Ozono",
          "µg/m³",
          "2009-01-04T00:00:00.000",
          null);
      Sensor sensor6 = Sensor(
          71,
          "12695",
          "Sondrio - via Paribelli",
          "1264",
          "46.167852440665115",
          "9.879209924469903",
          "Piombo",
          "ng/m³",
          "2008-04-01T00:00:00.000",
          null);

      List<Sensor> slAll = [];
      slAll.add(sensor1);
      slAll.add(sensor2);
      slAll.add(sensor3);
      slAll.add(sensor4);
      slAll.add(sensor5);
      slAll.add(sensor6);

      List<Sensor> sensorList = await getSensorListClosedtoUser(
          slAll, ulat, ulong, utol);

      print("Numero di sensori: " + sensorList.length.toString());

      for (sensor in sensorList) {
        print(sensor.sensor);
      }
    });
  });

  group('Quality air index group -', () {
    // One one value received for each sensor
    test('One value received for each sensor ', () {
      PollutantAgent pa = new PollutantAgent(1, 2, 3, 4, 5, 6);

      pa.set_values(
          1,
          2,
          15,
          18,
          150,
          370,
          250,
          29);
      print("PM10 index: " + pa.get_pm10_value().toString());
      print("PM10 index bck: " + pa.get_pm10_bck().toString());
      print("PM25 index: " + pa.get_pm25_value().toString());
      print("PM25 index bck: " + pa.get_pm25_bck().toString());
      print("NO2 index: " + pa.get_no2_value().toString());
      print("NO2 index bck: " + pa.get_no2_bck().toString());
      print("O3 index: " + pa.get_o3_value().toString());
      print("O3 index bck: " + pa.get_o3_bck().toString());
      print("SO2 index: " + pa.get_so2_value().toString());
      print("SO2 index bck: " + pa.get_so2_bck().toString());
      print("CO index: " + pa.get_co_value().toString());
      print("CO index bck: " + pa.get_co_bck().toString());

      expect(pa.get_pm10_value(), 1.00);
      expect(pa.get_pm25_value(), 0.8);
      expect(pa.get_no2_value(), 0.6);
      expect(pa.get_so2_value(), 0.4);
      expect(pa.get_o3_value(), 0.2);
      expect(pa.get_co_value(), 0.6);
    });

    // Two values received for each sensor
    test(
        'Two values received for each sensor and the hour,day dont change', () {
      PollutantAgent pa = PollutantAgent(1, 2, 3, 4, 5, 6);

      pa.set_values(
          1,
          2,
          15,
          18,
          150,
          370,
          250,
          29);
      pa.set_values(
          1,
          2,
          150,
          20,
          50,
          400,
          90,
          28);
      print("PM10 index: " + pa.get_pm10_value().toString());
      print("PM10 index bck: " + pa.get_pm10_bck().toString());
      print("PM25 index: " + pa.get_pm25_value().toString());
      print("PM25 index bck: " + pa.get_pm25_bck().toString());
      print("NO2 index: " + pa.get_no2_value().toString());
      print("NO2 index bck: " + pa.get_no2_bck().toString());
      print("O3 index: " + pa.get_o3_value().toString());
      print("O3 index bck: " + pa.get_o3_bck().toString());
      print("SO2 index: " + pa.get_so2_value().toString());
      print("SO2 index bck: " + pa.get_so2_bck().toString());
      print("CO index: " + pa.get_co_value().toString());
      print("CO index bck: " + pa.get_co_bck().toString());

      expect(pa.get_pm10_value(), 1.00);
      expect(pa.get_pm25_value(), 0.8);
      expect(pa.get_no2_value(), 0.6);
      expect(pa.get_so2_value(), 0.4);
      expect(pa.get_o3_value(), 0.2);
      expect(pa.get_co_value(), 0.6);
    });

    // Two values received for each sensor
    test(
        'Two values received for each sensor and the hour changed, the day dont changed', () {
      PollutantAgent pa = PollutantAgent(1, 2, 3, 4, 5, 6);

      pa.set_values(
          1,
          2,
          15,
          18,
          150,
          370,
          250,
          29);
      pa.set_values(
          2,
          2,
          150,
          20,
          50,
          400,
          90,
          28);
      print("PM10 index: " + pa.get_pm10_value().toString());
      print("PM10 index bck: " + pa.get_pm10_bck().toString());
      print("PM25 index: " + pa.get_pm25_value().toString());
      print("PM25 index bck: " + pa.get_pm25_bck().toString());
      print("NO2 index: " + pa.get_no2_value().toString());
      print("NO2 index bck: " + pa.get_no2_bck().toString());
      print("O3 index: " + pa.get_o3_value().toString());
      print("O3 index bck: " + pa.get_o3_bck().toString());
      print("SO2 index: " + pa.get_so2_value().toString());
      print("SO2 index bck: " + pa.get_so2_bck().toString());
      print("CO index: " + pa.get_co_value().toString());
      print("CO index bck: " + pa.get_co_bck().toString());

      expect(pa.get_pm10_value(), 0.6);
      expect(pa.get_pm25_value(), 0.8);
      expect(pa.get_no2_value(), 0.7);
      expect(pa.get_so2_value(), 0.4);
      expect(pa.get_o3_value(), 0.5);
      expect(pa.get_co_value(), 0.6);
    });

    // One one value received for each sensor
    test('Two values received for each sensor and the hour,day changed', () {
      PollutantAgent pa = PollutantAgent(1, 2, 3, 4, 5, 6);

      pa.set_values(
          1,
          2,
          15,
          18,
          150,
          370,
          250,
          29);
      pa.set_values(
          2,
          3,
          150,
          20,
          50,
          400,
          90,
          28);
      print("PM10 index: " + pa.get_pm10_value().toString());
      print("PM10 index bck: " + pa.get_pm10_bck().toString());
      print("PM25 index: " + pa.get_pm25_value().toString());
      print("PM25 index bck: " + pa.get_pm25_bck().toString());
      print("NO2 index: " + pa.get_no2_value().toString());
      print("NO2 index bck: " + pa.get_no2_bck().toString());
      print("O3 index: " + pa.get_o3_value().toString());
      print("O3 index bck: " + pa.get_o3_bck().toString());
      print("SO2 index: " + pa.get_so2_value().toString());
      print("SO2 index bck: " + pa.get_so2_bck().toString());
      print("CO index: " + pa.get_co_value().toString());
      print("CO index bck: " + pa.get_co_bck().toString());

      expect(pa.get_pm10_bck(), 1.00);
      expect(pa.get_pm25_bck(), 0.8);
      expect(pa.get_no2_bck(), 0.6);
      expect(pa.get_so2_bck(), 0.4);
      expect(pa.get_o3_bck(), 0.2);
      expect(pa.get_co_bck(), 0.6);
      expect(pa.get_pm10_value(), 0.2);
      expect(pa.get_pm25_value(), 0.8);
      expect(pa.get_no2_value(), 0.8);
      expect(pa.get_so2_value(), 0.4);
      expect(pa.get_o3_value(), 0.8);
      expect(pa.get_co_value(), 0.6);
    });

    // Reward: Two values received for each sensor
    test(
        'Reward: Two values received for each sensor and the hour,day dont change', () {
      PollutantAgent pa = PollutantAgent(1, 2, 3, 4, 5, 6);

      pa.set_values(
          1,
          2,
          15,
          18,
          150,
          370,
          250,
          29);
      pa.set_values(
          1,
          2,
          150,
          20,
          50,
          400,
          90,
          28);
      print("PM10 index: " + pa.get_pm10_rw().toString());
      print("PM25 index: " + pa.get_pm25_rw().toString());
      print("NO2 index: " + pa.get_no2_rw().toString());
      print("O3 index: " + pa.get_o3_rw().toString());
      print("SO2 index: " + pa.get_so2_rw().toString());
      print("CO index: " + pa.get_co_rw().toString());

      expect(pa.get_pm10_rw(), 1.00);
      expect(pa.get_pm25_rw(), 0.8);
      expect(pa.get_no2_rw(), 0.6);
      expect(pa.get_so2_rw(), 0.4);
      expect(pa.get_o3_rw(), 0.2);
      expect(pa.get_co_rw(), 0.6);
    });

    // Reward: Two vwlues received for each sensor and the hour changed
    test(
        'Reward: Two values received for each sensor and the hour changed, the day dont changed', () {
      PollutantAgent pa = PollutantAgent(1, 2, 3, 4, 5, 6);

      pa.set_values(
          1,
          2,
          15,
          18,
          150,
          370,
          250,
          29);
      pa.set_values(
          2,
          2,
          150,
          20,
          50,
          400,
          90,
          28);
      print("PM10 index: " + pa.get_pm10_rw().toString());
      print("PM25 index: " + pa.get_pm25_rw().toString());
      print("NO2 index: " + pa.get_no2_rw().toString());
      print("O3 index: " + pa.get_o3_rw().toString());
      print("SO2 index: " + pa.get_so2_rw().toString());
      print("CO index: " + pa.get_co_rw().toString());

      expect(pa.get_pm10_rw(), 1.60);
      expect(pa.get_pm25_rw(), 1.60);
      expect(pa.get_no2_rw(), 1.30);
      expect(pa.get_so2_rw(), 0.80);
      expect(pa.get_o3_rw(), 0.70);
      expect(pa.get_co_rw(), 1.20);
    });
  });

  group('Widget test -', () {
    // logged_in_widget test
    testWidgets('Logged_in_widget test ', (WidgetTester tester) async {

      // Find all the widget needed
      final addField = find.byKey(ValueKey("Test"));
      final addButton = find.byKey(ValueKey("Test"));

      //execute the actual test
      //await tester.pumpWidget(MaterialApp(home: Home()));
      await tester.enterText(addField, "Testing ....");
      await tester.tap(addButton);
      await tester.pump();

      // Cehck outputs
      expect(find.text("Make widget testing"), findsOneWidget);

    });
  });
}