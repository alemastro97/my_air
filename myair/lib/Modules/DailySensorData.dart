
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DailySensorData {

  var _values = ValueNotifier<List<double>>([]);

  DailySensorData() {
    for (var i = 0; i < 24; i++) {
      this._values.value.add(0.0);
    }
  }

  ValueListenable<List<double>> getValues() {
    return _values;
  }

  double getValue(int pos) {
    return _values.value[pos];
  }

  double getSum() {
    double sum = 0;

    for(int i=0; i<_values.value.length; i++) {
      sum = sum + _values.value[i];
    }

    return sum;
  }

   void setDataAverage(double average, int hour)  {
    this._values.value[hour] = this._values.value[hour] == 0.0 ? average : (this._values.value[hour] + average) / 2;
  }

}

