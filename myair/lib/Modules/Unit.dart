
// Unit class realted to sensors
class Unit {

  int _id;
  String _unit;
  String _idunit;
  //LatLng _coordinate;
  double _lat;
  double _lng;

  Unit(this._id, this._unit, this._idunit, this._lat, this._lng);

  int get id => _id;
  String get unit => _unit;
  String get idunit => _idunit;
  double get lat => _lat;
  double get lng => _lng;

  set id(int newid) {
    this._id = newid;
  }

  set unit(String newUnit) {
    this._unit = newUnit;
  }

  set idunit(String newidUnit) {
    this._idunit = newidUnit;
  }

  set lat(double newLat) {
    this._lat = newLat;
  }

  set lng(double newLng) {
    this._lng = newLng;
  }

  // Convert a Unit object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['unit_id'] = _id;
    }
    map['unit_name'] = _unit;
    map['unit_identifier'] = _idunit;
    map['unit_lat'] = _lat;
    map['unit_lng'] = _lng;

    return map;
  }

  // Extract a Sensor object from a Map object
  Unit.fromMapObject(Map<String, dynamic> map) {
    _id = map['unit_id'];
    _unit = map['unit_name'];
    _idunit = map['unit_identifier'];
    _lat = map['unit_lat'];
    _lng = map['unit_lng'];
  }

  Unit.fromJson(Map<String, dynamic> json) {

    _unit = json['nomestazione'];
    _idunit = json['idstazione'];
    _lat = json['lat'];
    _lng = json['lng'];

  }

}

