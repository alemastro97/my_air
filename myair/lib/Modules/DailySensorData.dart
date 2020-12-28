import "package:myair/Modules/sensordata.dart";

class DailySensorData {

  List<double> _values = [];

  DailySensorData() {
    for (var i = 0; i < 24; i++) {
      this._values.add(0.0);
    }
  }

  List<double> getValues() {
    return _values;
  }

  double getSum() {
    double sum = 0;

    for(int i=0; i<24; i++) {
      sum = sum + _values[i];
    }

    return sum;
  }

  Future<void> setDataAverage(double average, int hour) async {
    this._values[hour] = (this._values[hour] + average) / 2;
  }

}

