class Sensor {

  int _id;
  String _sensor;
  String _unit;
  String _idunit;
  String _lat;
  String _lng;
  String _name;
  String _uom;
  String _start;
  String _stop;

  Sensor(this._id, this._sensor, this._unit, this._idunit, this._lat, this._lng, this._name, this._uom, this._start, this._stop);

  int get id => _id;
  String get sensor => _sensor;
  String get unit => _unit;
  String get idunit => _idunit;
  String get lat => _lat;
  String get lng => _lng;
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

  set lat(String newLat) {
    this._lat = newLat;
  }

  set lng(String newLng) {
    this._lng = newLng;
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
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['name'] = _name;
    map['uom'] = _uom;
    map['start'] = _start;
    map['stop'] = _stop;

    return map;
  }

  // Extract a Sensor object from a Map object
  Sensor.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _sensor = map['sensor'];
    _unit = map['unit'];
    _idunit = map['idunit'];
    _lat = map['lat'];
    _lng = map['lng'];
    _name = map['name'];
    _uom = map['uom'];
    _start = map['start'];
    _stop = map['stop'];
  }

  Sensor.fromJson(Map<String, dynamic> json) {

    _sensor = json['idsensore'];
    _idunit = json['idstazione'];
    _unit = json['nomestazione'];
    _lat = json['lat'];
    _lng = json['lng'];
    _name = json['nometiposensore'];
    _uom = json['unitamisura'];
    _start = json['datastart'];
    _stop = json['datastop'];

  }
}
