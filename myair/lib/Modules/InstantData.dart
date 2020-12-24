class InstantData {
  String _idSensor;
  String _pollutantName;
  String _value;
  String _timestamp;
  String _placeName;

  ///Constructor
  InstantData(this._idSensor, this._pollutantName, this._value, this._timestamp, this._placeName);

  ///Getter
  String get sensor => _idSensor;
  String get pollutantName => _pollutantName;
  String get value => _value;
  String get timestamp => _timestamp;
  String get placeName => _placeName;

  ///Setter
  set sensor(String newIdSensor) {
    this._idSensor = newIdSensor;
  }

  set pollutantName(String pollutantName) {
    this._pollutantName = pollutantName;
  }

  set value(String value) {
    this._value = value;
  }

  set timestamp(String timestamp) {
    this._timestamp = timestamp;
  }

  set placeName(String placeName) {
    this._placeName = placeName;
  }
}