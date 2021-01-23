// Sensor data class
class SensorData {

  int _id;  //ID in the internal database
  String _sensor; //ID of the sensor in the ARPA DB
  String _timestamp;
  String _value;
  String _state;
  String _operator;

  //Construct
  SensorData(this._id, this._sensor, this._timestamp, this._value, this._state, this._operator);

  //Getters
  int get id => _id;
  String get sensor => _sensor;
  String get timestamp => _timestamp;
  String get value => _value;
  String get state => _state;
  String get operator => _operator;

  //Setters
  set sensor(String newSensor) {
    this._sensor = newSensor;
  }
  set timestamp(String newTimestamp) {
    this._timestamp = newTimestamp;
  }
  set value(String newValue) {
    this._value = newValue;
  }
  set state(String newState) {
    this._state = newState;
  }
  set operator(String newOperator) {
    this._operator = newOperator;
  }

  // Convert a Sensor data object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['sensor'] = _sensor;
    map['timestamp'] = _timestamp;
    map['value'] = _value;
    map['state'] = _state;
    map['operator'] = _operator;

    return map;
  }

  // Extract a Sensor object from a Map object
  SensorData.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _sensor = map['sensor'];
    _timestamp = map['timestamp'];
    _value = map['value'];
    _state = map['state'];
    _operator = map['operator'];
  }

  //Extract data from the JSON by Firebase
  SensorData.fromJson(Map<String, dynamic> json) {
    _sensor = json['idsensore'];
    _timestamp = json['data'];
    _value = json['valore'];
    _state = json['stato'];
    _operator = json['idoperatore'];
  }

}
