import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:myair/Modules/sensor.dart';
import 'package:myair/Modules/unit.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as Math;

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

  String unitTable = 'unit_table';
  String uId = 'unit_id';
  String uUnit = 'unit_name';
  String uidUnit = 'unit_identifier';
  String uLat= 'unit_lat';
  String uLng = 'unit_lng';

  String userTable = 'User';
  String userId = 'userId';
  String firstName = 'firstName';
  String lastName = 'lastName';
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
    _databaseHelper.deleteUnit();
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
    await db.execute('CREATE TABLE $unitTable($uId INTEGER PRIMARY KEY AUTOINCREMENT, $uUnit TEXT, '
        '$uidUnit TEXT, $uLat TEXT, $uLng TEXT)');
    await db.execute('CREATE TABLE $userTable($userId INTEGER PRIMARY KEY AUTOINCREMENT, $firstName TEXT, '
        '$lastName TEXT, $email TEXT, $password TEXT, $image TEXT)');

  }

  // Fetch operation
  Future<List<Map<String, dynamic>>> getSensorMapList() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM $sensorTable order by $colidUnit');
    return result;
  }

  Future<List<Map<String, dynamic>>> getUnitMapList() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM $unitTable order by $uidUnit');
    return result;
  }

  // Insert operation
  Future<int> insertSensor(Sensor sensor) async {
    Database db = await this.database;

    var result = await db.insert(sensorTable, sensor.toMap());
    return result;
  }

  Future<int> insertUnit(Unit unit) async {
    Database db = await this.database;

    var result = await db.insert(unitTable, unit.toMap());
    return result;
  }

  // Delete all objects
  Future<int> deleteSensor() async {
    var db = await this.database;

    int result = await db.rawDelete('DELETE FROM $sensorTable');
    return result;
  }

  Future<int> deleteUnit() async {
    var db = await this.database;

    int result = await db.rawDelete('DELETE FROM $unitTable');
    return result;
  }

  // Get number of objects in database
  Future<int> getCountSensor() async{
    Database db = await this.database;

    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) FROM $sensorTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCountUnit() async{
    Database db = await this.database;

    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) FROM $unitTable');
    int result = Sqflite.firstIntValue(x);

    print("Number of unit:" + result.toString());
    return result;
  }

  // Get the 'Map List' and convert to 'Object List'
  Future<List<Sensor>> getSensorList() async {
    var sensorMapList = await getSensorMapList(); // Get 'Map List' from database
    int count = sensorMapList.length; // Count the number of map entries in the db
    print("xxxxxxxxxxxxxxxxxxxxxxxx" + count.toString());
    List<Sensor> sensorList = List<Sensor>();
    for (int i = 0; i < count; i++) {
      sensorList.add(Sensor.fromMapObject(sensorMapList[i]));
    }

    return sensorList;
  }

  Future<List<Unit>> getUnitList() async {
    var unitMapList = await getUnitMapList(); // Get 'Map List' from database
    int count = unitMapList.length; // Count the number of map entries in the db

    List<Unit> unitList = List<Unit>();
    for (int i = 0; i < count; i++) {
      unitList.add(Unit.fromMapObject(unitMapList[i]));
    }

    return unitList;
  }

  Future<Unit> getUnit(String idunit) async {
    var unitMapList = await getUnitMapList(); // Get 'Map List' from database
    Unit unit;

    int count = unitMapList.length; // Count the number of map entries in the db

    for (int i = 0; i < count; i++) {
      unit = Unit.fromMapObject(unitMapList[i]);

      if (unit.idunit == idunit)
        return unit;
    }

    return unit;
  }


// Get the sensor list closed to the user
  Future<List<Sensor>> getSensorListClosedtoUser(double ulatitude, double ulongitude, int utolerance) async {
    var sensorMapList = await getSensorMapList(); // Get 'Map List' from database
    int count = sensorMapList.length; // Count the number of map entries in the db

    List<Sensor> sensorList = List<Sensor>();
    Sensor sensor;
    var distanceMeters, distanceMeters2;
    var lat, lng;

    print("Checking DB sensors (" + count.toString() + ")");

    for (int i = 0; i < count; i++) {

      sensor = Sensor.fromMapObject(sensorMapList[i]);
      lat = sensor.lat;
      lng =sensor.lng;
      distanceMeters = Geolocator.distanceBetween(ulatitude, ulongitude, double.parse(lat), double.parse(lng));
      distanceMeters2 = getDistance(ulatitude, ulongitude, double.parse(lat), double.parse(lng));


      if (distanceMeters < utolerance) {
        sensorList.add(Sensor.fromMapObject(sensorMapList[i]));
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