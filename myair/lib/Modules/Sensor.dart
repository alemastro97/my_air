import 'package:latlong/latlong.dart';
// Sensor class
class SensorModule {

  int _id; ///Id in the local database
  String _sensor; ///Id of the sensor
  String _unit; ///Station name
  String _idunit; ///station id
  LatLng _position;
  String _name; ///Name of the pollutant agent measured
  String _uom; ///Unit of Measurement
  String _start;
  String _stop;
//TODO delete the stop parameter
  SensorModule(this._id, this._sensor, this._unit, this._idunit, this._position, this._name, this._uom, this._start, this._stop);

  int get id => _id;
  String get sensor => _sensor;
  String get unit => _unit;
  String get idunit => _idunit;
  LatLng get position => _position;
  String get name => _name;
  String get uom => _uom;
  String get start => _start;
  String get stop => _stop;

  set sensor(String newSensor) {
    this._sensor = newSensor;
  }

  set unit(String newUnit) {
    this._unit = newUnit;
  }

  set idunit(String newidUnit) {
    this._idunit = newidUnit;
  }

  set position(LatLng newPosition) {
    this._position= newPosition;
  }

  set name(String newName) {
    this._name = newName;
  }

  set uom(String newuom) {
    this._uom = newuom;
  }

  set start(String newStart) {
    this._start = newStart;
  }

  set stop(String newStop) {
    this._stop = newStop;
  }

  // Convert a Sensor object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['sensor'] = _sensor;
    map['unit'] = _unit;
    map['idunit'] = _idunit;
    map['lat'] = _position.latitude.toString();
    map['lng'] = _position.longitude.toString();
    map['name'] = _name;
    map['uom'] = _uom;
    map['start'] = _start;
    map['stop'] = _stop;

    return map;
  }

  // Extract a Sensor object from a Map object
  SensorModule.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _sensor = map['sensor'];
    _unit = map['unit'];
    _idunit = map['idunit'];
    _position = new LatLng(double.parse(map['lat']),double.parse(map['lng']));
    _name = map['name'];
    _uom = map['uom'];
    _start = map['start'];
    _stop = map['stop'];
  }

  SensorModule.fromJson(Map<String, dynamic> json) {

    _sensor = json['idsensore'];
    _idunit = json['idstazione'];
    _unit = json['nomestazione'];
    _position = new LatLng(double.parse(json['lat']),double.parse(json['lng']));
    _name = json['nometiposensore'];
    _uom = json['unitamisura'];
    _start = json['datastart'];
    _stop = json['datastop'];

  }

}
