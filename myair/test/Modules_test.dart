
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:myair/Modules/ActualValue.dart';
import 'package:myair/Modules/DailySensorData.dart';
import 'package:myair/Modules/PollutantAgent.dart';
import 'package:myair/Modules/SensorListData.dart';
import 'package:myair/Modules/Sensor.dart';
import 'package:myair/Modules/SensorData.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:latlong/latlong.dart';
import 'package:myair/Modules/UserAccount.dart';
import 'package:myair/Views/Graph_view/ChartPage.dart';
import 'package:myair/Views/Home_page_views/HomeStatisticsPage.dart';
import 'package:myair/Views/Reward_page/RewardPage.dart';
import 'package:myair/Views/Settings_view/SettingsPage.dart';
import 'package:myair/Widgets/ChartPage_widgets/AnimatedChart.dart';
import 'package:myair/Widgets/ChartPage_widgets/BarChartPreview.dart';
import 'package:myair/Widgets/ChartPage_widgets/ChartCardWidget.dart';
import 'package:myair/Widgets/ChartPage_widgets/ScrollableTabBar.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/AgentInfoWidget.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/AgentPieChart.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/GridAgentWidget.dart';
import 'package:myair/Widgets/Reward_page_widgets/ActiveReward.dart';
import 'package:myair/Widgets/Settings_page_widgets/SettingsPageWidget.dart';
import 'package:myair/Widgets/Settings_page_widgets/SliderAgent.dart';
import 'package:myair/main.dart';

void main() {
  group('Sensor data checking -', () {
    // Same value for the 24h-array
    test('Test 01', () {
      List<SensorData> data_sensor = [];
      SensorData sensordata;

      sensordata = new SensorData(1, 'sensor01', '2020-12-26T00:00:00,000', '0.84', 'state1','operator1');
      for (int i = 0; i < 24; i++) {
        data_sensor.add(sensordata);
      }

      double result = actualAverage(data_sensor);

      expect(result, 0.84);
    });

    // Different value only for the position of the hour of the test
    // Set the value according the hour of the test
    test('Test 02', () {
      List<SensorData> data_sensor = [];
      SensorData sensordata1, sensordata2;
      sensordata1 = new SensorData(
          1, 'sensor01', '2020-12-26T01:00:00,000', '0.84', 'state1',
          'operator1');
      sensordata2 = new SensorData( //<------------ Set the value according the hour of the test
          1, 'sensor01', '2020-12-26T22:00:00,000', '0.78', 'state1',
          'operator1');

      for (int i = 0; i < 24; i++) {
        if (i == 22) { // <------------ Set the value according the hour of the test
          data_sensor.add(sensordata2);
        }
        else {
          data_sensor.add(sensordata1);
        }
      }

      double result = actualAverage(data_sensor);

      expect(result, 0.8335714285714285);
    });

    // Average calculus
    test('Test 03', () {
      double sensor_value = 0.78;
      int hour = DateTime.now().hour;

      DailySensorData st = DailySensorData();

      for (int i = 0; i < 10; i++) {
        st.setDataAverage(sensor_value, hour);
      }

      expect((st.getValue(hour) * 1000).round() / 1000, 0.78);
    });

    // Sum of the values in the array
    test('Test 04', () {
      double average = 0.5;

      DailySensorData st = DailySensorData();

      for (int i = 0; i < 24; i++) {
        st.setDataAverage(average, i);

        average = average + 0.1;
      }

      expect((st.getSum() * 10).round() / 10, 39.6);
    });

    // Looking for the sensor closed to users in a range of 100 Km
    test('Test 05', () async {
      double ulat = 45.443857653564926;
      double ulong = 9.167944501742676;
      int utol = 100000;
      SensorModule sensor;
      SensorModule sensor1 = SensorModule(
          121,
          "5718",
          "Magenta",
          "546",
          new LatLng(45.462415791106615, 8.880210433125571),
          "Ozono",
          "µg/m³",
          "1995-07-29T00:00:00.000",
          null);
      SensorModule sensor2 = SensorModule(
          464,
          "5823",
          "Milano - viale Liguria",
          "539",
          new LatLng(45.443857653564926,9.167944501742676),
          "Monossido di Carbonio",
          "mg/m³",
          "1991-10-20T00:00:00.000",
          null);
      SensorModule sensor3 = SensorModule(
          24,
          "6328",
          "Milano - viale Marche",
          "501",
          new LatLng(45.49631644365102,9.190933555313624),
          "Ossidi di Azoto",
          "µg/m³",
          "1980-09-18T00:00:00.000",
          null);
      SensorModule sensor4 = SensorModule(
          90,
          "10458",
          "Bertonico",
          "1266",
          new LatLng(45.23349364130374,9.666250375296032),
          "Biossido di Azoto",
          "µg/m³",
          "2009-08-03T00:00:00.000",
          null);
      SensorModule sensor5 = SensorModule(
          81,
          "10437",
          "Sondrio - via Paribelli",
          "1264",
          new LatLng(46.167852440665115,9.879209924469903),
          "Ozono",
          "µg/m³",
          "2009-01-04T00:00:00.000",
          null);
      SensorModule sensor6 = SensorModule(
          71,
          "12695",
          "Sondrio - via Paribelli",
          "1264",
          new LatLng(46.167852440665115,9.879209924469903),
          "Piombo",
          "ng/m³",
          "2008-04-01T00:00:00.000",
          null);

      List<SensorModule> slAll = [];
      slAll.add(sensor1);
      slAll.add(sensor2);
      slAll.add(sensor3);
      slAll.add(sensor4);
      slAll.add(sensor5);
      slAll.add(sensor6);

      List<SensorModule> sensorList = await getSensorListClosedtoUser(
          slAll, ulat, ulong, utol);

      expect(sensorList.length, 6);
    });

  // Looking for the sensor closed to users in a range of 10 Km
    test('Test 06', () async {
      double ulat = 45.443857653564926;
      double ulong = 9.167944501742676;
      int utol = 10000;
      SensorModule sensor;
      SensorModule sensor1 = SensorModule(
        121,
        "5718",
        "Magenta",
        "546",
        new LatLng(45.462415791106615, 8.880210433125571),
        "Ozono",
        "µg/m³",
        "1995-07-29T00:00:00.000",
        null);
      SensorModule sensor2 = SensorModule(
        464,
        "5823",
        "Milano - viale Liguria",
        "539",
        new LatLng(45.443857653564926,9.167944501742676),
        "Monossido di Carbonio",
        "mg/m³",
        "1991-10-20T00:00:00.000",
        null);
      SensorModule sensor3 = SensorModule(
        24,
        "6328",
        "Milano - viale Marche",
        "501",
        new LatLng(45.49631644365102,9.190933555313624),
        "Ossidi di Azoto",
        "µg/m³",
        "1980-09-18T00:00:00.000",
        null);
      SensorModule sensor4 = SensorModule(
        90,
        "10458",
        "Bertonico",
        "1266",
        new LatLng(45.23349364130374,9.666250375296032),
        "Biossido di Azoto",
        "µg/m³",
        "2009-08-03T00:00:00.000",
        null);
      SensorModule sensor5 = SensorModule(
        81,
        "10437",
        "Sondrio - via Paribelli",
        "1264",
        new LatLng(46.167852440665115,9.879209924469903),
        "Ozono",
        "µg/m³",
        "2009-01-04T00:00:00.000",
        null);
      SensorModule sensor6 = SensorModule(
        71,
        "12695",
        "Sondrio - via Paribelli",
        "1264",
        new LatLng(46.167852440665115,9.879209924469903),
        "Piombo",
        "ng/m³",
        "2008-04-01T00:00:00.000",
        null);

      List<SensorModule> slAll = [];
      slAll.add(sensor1);
      slAll.add(sensor2);
      slAll.add(sensor3);
      slAll.add(sensor4);
      slAll.add(sensor5);
      slAll.add(sensor6);

      List<SensorModule> sensorList = await getSensorListClosedtoUser(
        slAll, ulat, ulong, utol);

      expect(sensorList.length, 2);
    });
  });

  group('Rewarding and notification', () {

    // One value received for each sensor
    test('Test 07', () {
      PollutantAgent pa = new PollutantAgent();
      pa.initialize(1, 2, 3, 4, 5, 6);
      pa.set_values(
          1,
          2,
          15,
          18,
          150,
          370,
          250,
          29);

      expect(pa.get_pm10_value(), 1.00);
      expect(pa.get_pm25_value(), 0.8);
      expect(pa.get_no2_value(), 0.6);
      expect(pa.get_so2_value(), 0.4);
      expect(pa.get_o3_value(), 0.2);
      expect(pa.get_co_value(), 0.2);
    });

    // Two values received for each sensor in order to test the average
    test('Test  08', () {
      PollutantAgent pa = new PollutantAgent();
      pa.initialize(1, 2, 3, 4, 5, 6);
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

      expect(pa.get_pm10_value(), 1.00);
      expect(pa.get_pm25_value(), 0.8);
      expect(pa.get_no2_value(), 0.6);
      expect(pa.get_so2_value(), 0.4);
      expect(pa.get_o3_value(), 0.2);
      expect(pa.get_co_value(), 0.2);

    });

    // Two values received for each sensor in order to test the average
    test('Test 09', () {
      PollutantAgent pa = new PollutantAgent();
      pa.initialize(1, 2, 3, 4, 5, 6);
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

      expect(pa.get_pm10_value(), 0.6);
      expect(pa.get_pm25_value(), 0.8);
      expect(pa.get_no2_value(), 0.7);
      expect(pa.get_so2_value(), 0.4);
      expect(pa.get_o3_value(), 0.5);
      expect(pa.get_co_value(), 0.2);
    });

    // Test of the backup of data when day changes
    test('Test 10', () {
      PollutantAgent pa = new PollutantAgent();
      pa.initialize(1, 2, 3, 4, 5, 6);
      pa.set_values(1,2,15,18,150,370,250,29);
      pa.set_values(2,3,150,20,50,400,90,28);

      expect(pa.get_pm10_bck(), 1.00);
      expect(pa.get_pm25_bck(), 0.8);
      expect(pa.get_no2_bck(), 0.6);
      expect(pa.get_so2_bck(), 0.4);
      expect(pa.get_o3_bck(), 0.2);
      expect(pa.get_co_bck(), 0.2);
      expect(pa.get_pm10_value(), 0.2);
      expect(pa.get_pm25_value(), 0.8);
      expect(pa.get_no2_value(), 0.8);
      expect(pa.get_so2_value(), 0.4);
      expect(pa.get_o3_value(), 0.8);
      expect(pa.get_co_value(), 0.2);
    });

    // Reward: Two values received for each sensor
    test('Test 11', () {
      PollutantAgent pa = new PollutantAgent();
      pa.initialize(1, 2, 3, 4, 5, 6);
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

      expect(pa.get_pm10_rw(), 1.00);
      expect(pa.get_pm25_rw(), 1.6);
      expect(pa.get_no2_rw(), 1.2);
      expect(pa.get_so2_rw(), 0.8);
      expect(pa.get_o3_rw(), 0.4);
      expect(pa.get_co_rw(), 0.4);
    });

    // Reward: Two values received for each sensor. The hour changed
    test('Test 12', () {
      PollutantAgent pa = new PollutantAgent();
      pa.initialize(1, 2, 3, 4, 5, 6);
      pa.set_values(1,2,15,18,150,370,250,29);
      pa.set_values(2,2,150,20,50,400,90,28);

      expect(pa.get_pm10_rw(), 1.00);
      expect(pa.get_pm25_rw(), 1.60);
      expect(pa.get_no2_rw(), 1.2999999999999998);
      expect(pa.get_so2_rw(), 0.80);
      expect(pa.get_o3_rw(), 0.70);
      expect(pa.get_co_rw(), 0.40);
    });

    // Reward: Notifications of the termination of the cycle for pm10
    test('Test 13', ()
    {
      PollutantAgent pa = new PollutantAgent();
      pa.initialize(5, 2, 3, 4, 5, 6);
      pa.set_values(1,2,15,18,150,370,250,29);
      pa.set_values(1,2,15,18,150,370,250,29);
      pa.set_values(1,2,15,18,150,370,250,29);
      pa.set_values(1,2,15,18,150,370,250,29);
      pa.set_values(1,2,15,18,150,370,250,29);

      expect(pa.get_pm10_rw(),5);
      expect(pa.get_pm10_notify(),true);
    });

    // Reward: No notifications of the termination of the cycle for pm10
    test('Test 14', ()
    {
      //PollutantAgent pa = PollutantAgent(6, 1, 2, 3, 4, 5);
      PollutantAgent pa = new PollutantAgent();
      pa.initialize(5, 2, 3, 4, 5, 6);
      pa.set_values(1,2,15,18,150,370,250,29);
      pa.set_values(1,2,15,18,150,370,250,29);
      pa.set_values(1,2,15,18,150,370,250,29);
      pa.set_values(1,2,15,18,150,370,250,29);

      expect(pa.get_pm10_rw(),4);
      expect(pa.get_pm10_notify(),false);
    });

  });

  group('Widget tes', () {
    // logged_in_widget test
    testWidgets('Test 15', (WidgetTester tester) async {

      actualUser = new UserAccount("aristide", "bordoli", "aristide.bordoli@mail.polimi.it", "","",[100,50,400,500,240,10], true,true,DateFormat('MM-dd').format(DateTime.now()),0,true,0);

      PollutantAgent p = PollutantAgent();
      p.initialize(2,100,100,100,100,100);

      await tester.pumpWidget(MaterialApp(home: RewardPage()));


      expect(find.byType(ActiveReward),findsNWidgets(9));
    });
    testWidgets('Test 16', (WidgetTester tester) async {

      actualUser = new UserAccount("aristide", "bordoli", "aristide.bordoli@mail.polimi.it", "","",[100,50,400,500,240,10], true,true,DateFormat('MM-dd').format(DateTime.now()),0,true,0);

      ActualValue().initializeValues();
      await tester.pumpWidget(MaterialApp(home: SettingsPage()));


      expect(find.byType(SliderAgent),findsNWidgets(6));
    });

    testWidgets('Test 17', (WidgetTester tester) async {
      DailyUnitData().initializeValues();
      ActualValue().initializeValues();

      await tester.pumpWidget(MaterialApp(home: ChartPage()));

      expect(find.byType(AnimatedChart),findsNWidgets(1));
    });

    testWidgets('Test 18', (WidgetTester tester) async {
      ActualValue().initializeValues();

      await tester.pumpWidget(MaterialApp(home: HomeStatisticsPage()));

      expect( find.byType(GridAgentWidget),findsNWidgets(1));
    });

    testWidgets('Test 19', (WidgetTester tester) async {
      ActualValue().initializeValues();

      await tester.pumpWidget(MaterialApp(home: HomeStatisticsPage()));

      expect( find.byType(AgentInfoWidget),findsNWidgets(6));
    });
  });


}