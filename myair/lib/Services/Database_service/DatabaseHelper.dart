
import 'package:intl/intl.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Modules/UserAccount.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as Math;

import '../../Modules/Sensor.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper; //Singleton DatabaseHelper
  static Database _database;

///DATABASE TABLES
  String sensorTable = 'sensor_table';
  String colId = 'id';
  String colSensor = 'sensor';
  String colUnit = 'unit';
  String colidUnit = 'idunit';
  String colLat= 'lat';
  String colLng = 'lng';
  String colName = 'name';
  String colUOM = 'uom';
  String colStart = 'start';
  String colStop = 'stop';

  String userTable = 'User';
  String userId = 'userId';
  String userIdFirebase = 'firebaseId';
  String firstName = 'firstname';
  String lastName = 'lastname';
  String email = 'email';
  String password = 'password';
  String image = 'image';
  String pm10 = 'pm10';
  String pm25 = 'pm25';
  String no2 = 'no2';
  String so2 = 'so2';
  String o3 = 'o3';
  String co = 'co';
  String ns = 'notificationSend';
  String nr = 'notificationReward'; /// 0 (false) and 1 (true).
  String lastLog = 'lastLog';
  String hourSafe = 'hourSafe';
  String wf = 'weeklyMissionFailed';
  String counter = 'counter';

  String dataTable = 'Data';
  String dataId = 'dataId';
  String agent = 'agent';
  String hour = 'hour';
  String value = 'value';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper;

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // this is execute only once, singleton object
    }
    return _databaseHelper;
  }

  deleteDB(){
    _databaseHelper.deleteSensor();
    _databaseHelper.deleteUser();
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    // get the directory path for Android to store database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'sensors.db';

    // Open/create the database at the given path
    var sensorsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return sensorsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $sensorTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colSensor TEXT, $colUnit TEXT, '
        '$colidUnit TEXT, $colLat TEXT, $colLng TEXT, $colName TEXT, $colUOM TEXT, $colStart TEXT, $colStop TEXT)');
    await db.execute('CREATE TABLE $userTable($userId INTEGER PRIMARY KEY AUTOINCREMENT, $userIdFirebase TEXT,$firstName TEXT, '
        '$lastName TEXT, $email TEXT, $password TEXT, $image TEXT, $pm10 TEXT, $pm25 TEXT, $no2 TEXT, $so2 TEXT, $o3 TEXT, $co TEXT,$ns TEXT,$nr TEXT'
        ', $lastLog TEXT, $hourSafe TEXT, $wf TEXT,$counter TEXT)');
    await db.execute('CREATE TABLE $dataTable($dataId INTEGER PRIMARY KEY AUTOINCREMENT, $agent TEXT,$hour TEXT, $value TEXT)');
  }

  // Fetch operation
  Future<List<Map<String, dynamic>>> getSensorMapList() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM $sensorTable order by $colidUnit');
    return result;
  }

  Future<List<Map<String, dynamic>>> getUser() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM $userTable order by $userId');
    print(result.length);
    return result;
  }

  Future<List<Map<String, dynamic>>> getData() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $dataTable order by $dataId');
    return result;
  }

  // Insert operation
  Future<int> insertSensor(SensorModule sensor) async {
    Database db = await this.database;

    var result = await db.insert(sensorTable, sensor.toMap());
    return result;
  }

  Future<int> insertUser(UserAccount user) async {
    Database db = await this.database;

    var result = await db.insert(userTable, user.toMap());
    print(result);
    return result;
  }

  Future<void> insertDailyData() async {
    Database db = await this.database;
    deleteData();
    var pm10 = DailyUnitData().getPM10Values();
    var pm25 = DailyUnitData().getPM25Values();
    var no2 = DailyUnitData().getNO2Values();
    var so2 = DailyUnitData().getSO2Values();
    var o3 = DailyUnitData().getO3Values();
    var co = DailyUnitData().getCOValues();
    for(var index = 0; index < 24; index++){
      await db.insert(dataTable, mapData(pm10.value.elementAt(index),index, "pm10"));
      await db.insert(dataTable, mapData(pm25.value.elementAt(index),index, "pm25"));
      await db.insert(dataTable, mapData(no2.value.elementAt(index),index, "no2"));
      await db.insert(dataTable, mapData(so2.value.elementAt(index),index, "so2"));
      await db.insert(dataTable, mapData(o3.value.elementAt(index),index, "o3"));
      await db.insert(dataTable, mapData(co.value.elementAt(index),index, "co"));
    }
  }
  Map<String, dynamic> mapData(double value, int hour, String agent){
    var map = Map<String, dynamic>();
    map[this.agent] = agent;
    map[this.hour] = hour;
    map[this.value] = value;
    return map;
  }
  Future<int> deleteSensor() async {
    var db = await this.database;

    int result = await db.rawDelete('DELETE FROM $sensorTable');
    return result;
  }
  Future<int> deleteData() async {
    var db = await this.database;

    int result = await db.rawDelete('DELETE FROM $dataTable');
    return result;
  }

  Future<int> deleteUser() async {
    var db = await this.database;

    int result = await db.rawDelete('DELETE FROM $userTable');
    return result;
  }

  Future<int> setImg(String e,String img)async{
    var db = await this.database;

    int result = await db.rawUpdate('UPDATE $userTable SET $image =' + '\'' +
    img +
    '\'' + 'WHERE $email = ' + '\'' +
        e +
        '\'');
    print(img);
    print(result.toString());
    return result;
  }

  // Get number of objects in database
  Future<int> getCountSensor() async{
    Database db = await this.database;

    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) FROM $sensorTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get number of users
  Future<int> getCountUser() async{
    Database db = await this.database;

    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) FROM $userTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' and convert to 'Object List'
  Future<List<SensorModule>> getSensorList() async {
    var sensorMapList = await getSensorMapList(); // Get 'Map List' from database
    int count = sensorMapList.length; // Count the number of map entries in the db
    print("xxxxxxxxxxxxxxxxxxxxxxxx" + count.toString());
    List<SensorModule> sensorList = List<SensorModule>();
    for (int i = 0; i < count; i++) {
      sensorList.add(SensorModule.fromMapObject(sensorMapList[i]));
    }

    return sensorList;
  }

  // Get user account
  Future<UserAccount> getUserAccount() async {
    var user = await getUser(); // Get 'Map List' from database
    print("------" + user.length.toString());
    if(user.length > 0) {
      UserAccount account = UserAccount("firstName", "lastName", "email", "password", "",[],true,true,DateFormat('MM-dd').format(DateTime.now()),0,true,0) ;
      print(user.length);
      account.fromMapObject(user.elementAt(0));
      return account;
    }
    return null;
  }

  // Get Daily data
  void getDailyData() async {
    var data_list= await getData(); // Get 'Map List' from database
    if(data_list.length > 0) {
      data_list.forEach((data) {
        switch(data[agent]) {
          case "pm10": {
            DailyUnitData().setPM10Values(double.parse(data[value]), int.parse(data[hour]));
            print(data[value].toString() + " " + data[hour].toString());
          }
          break;
          case "pm25": {
            DailyUnitData().setPM25Values(double.parse(data[value]), int.parse(data[hour]));
          }
          break;
          case "no2": {
            DailyUnitData().setNO2Values(double.parse(data[value]), int.parse(data[hour]));
          }
          break;
          case "so2": {
            DailyUnitData().setSO2Values(double.parse(data[value]), int.parse(data[hour]));
          }
          break;
          case "o3": {
            DailyUnitData().setO3Values(double.parse(data[value]), int.parse(data[hour]));
          }
          break;
          case "co": {
            DailyUnitData().setCOValues(double.parse(data[value]), int.parse(data[hour]));
          }
          break;
          default: {
            print("error in data extracted");
          }
          break;
        }
      });
    }
  }

/* Get the sensor list closed to the user?????????????????????????????NOT USED !
  Future<List<SensorModule>> getSensorListClosedtoUser(double ulatitude, double ulongitude, int utolerance) async {
    var sensorMapList = await getSensorMapList(); // Get 'Map List' from database
    int count = sensorMapList.length; // Count the number of map entries in the db

    List<SensorModule> sensorList = List<SensorModule>();
    SensorModule sensor;
    var distanceMeters, distanceMeters2;
    var lat, lng;

    print("Checking DB sensors (" + count.toString() + ")");

    for (int i = 0; i < count; i++) {

      sensor = SensorModule.fromMapObject(sensorMapList[i]);
      lat = sensor.position.latitude;
      lng =sensor.position.longitude;
      distanceMeters = Geolocator.distanceBetween(ulatitude, ulongitude, double.parse(lat), double.parse(lng));
      distanceMeters2 = getDistance(ulatitude, ulongitude, double.parse(lat), double.parse(lng));


      if (distanceMeters < utolerance) {
        sensorList.add(SensorModule.fromMapObject(sensorMapList[i]));
        print("NeareSensnen" + SensorModule.fromMapObject(sensorMapList[i]).sensor.toString());
      }
    }

    return sensorList;
  }

  double getDistance(double lat1, lon1, lat2, lon2) {
    int R = 6371; // km
    double x = (lon2 - lon1) * Math.cos((lat1 + lat2) / 2);
    double y = (lat2 - lat1);
    double distance = Math.sqrt(x * x + y * y) * R;

    return distance;
  } */

}