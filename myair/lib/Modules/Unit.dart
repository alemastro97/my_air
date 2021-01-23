import 'package:latlong/latlong.dart';
// Unit class related to sensors
class Unit {

  int _id;
  String _unit; //Station Name
  String _idUnit; //Station id
  LatLng _position;

  //Constructor
  Unit(this._id, this._unit, this._idUnit, this._position);

  //Getter
  int get id => _id;
  String get unit => _unit;
  String get idunit => _idUnit;
  LatLng get position => _position;

  //Setter
  set id(int newid) {
    this._id = newid;
  }
  set unit(String newUnit) {
    this._unit = newUnit;
  }
  set idunit(String newidUnit) {
    this._idUnit = newidUnit;
  }
  set position(LatLng newPosition) {
    this._position = newPosition;
  }

}

