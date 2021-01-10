import 'package:latlong/latlong.dart';
// Unit class realted to sensors
class Unit {

  int _id;
  String _unit; ///Station Name
  String _idunit; ///Station id
  LatLng _position;
  //double _lat;
  //double _lng;

  Unit(this._id, this._unit, this._idunit, this._position);

  int get id => _id;
  String get unit => _unit;
  String get idunit => _idunit;
  LatLng get position => _position;

  set id(int newid) {
    this._id = newid;
  }

  set unit(String newUnit) {
    this._unit = newUnit;
  }

  set idunit(String newidUnit) {
    this._idunit = newidUnit;
  }

  set position(LatLng newPosition) {
    this._position = newPosition;
  }


  // Convert a Unit object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['unit_id'] = _id;
    }
    map['unit_name'] = _unit;
    map['unit_identifier'] = _idunit;
    map['unit_lat'] = _position.latitude;
    map['unit_lng'] = _position.longitude;

    return map;
  }

  // Extract a Sensor object from a Map object
  Unit.fromMapObject(Map<String, dynamic> map) {
    _id = map['unit_id'];
    _unit = map['unit_name'];
    _idunit = map['unit_identifier'];
    _position = new LatLng(double.parse(map['unit_lat']),double.parse(map['unit_lng']));
  }

  Unit.fromJson(Map<String, dynamic> json) {

    _unit = json['nomestazione'];
    _idunit = json['idstazione'];
    _position = new LatLng(double.parse(json['unit_lat']),double.parse(json['unit_lng']));

  }

}

