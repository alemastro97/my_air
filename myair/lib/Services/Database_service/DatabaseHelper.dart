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
        '$lastName TEXT, $email TEXT, $password TEXT, $image TEXT)');

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

  // Delete all objects
  Future<int> deleteSensor() async {
    var db = await this.database;

    int result = await db.rawDelete('DELETE FROM $sensorTable');
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

  Future<UserAccount> getUserAccount() async {
    var user = await getUser(); // Get 'Map List' from database
    print("------" + user.length.toString());
    if(user.length > 0) {
      UserAccount account = UserAccount("firstName", "lastName", "email", "password", "") ;
      print(user.length);
      account.fromMapObject(user.elementAt(0));
      return account;
    }
    print("Return null");
    return null;
  }

// Get the sensor list closed to the user
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
      lat = sensor.lat;
      lng =sensor.lng;
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
  }

}