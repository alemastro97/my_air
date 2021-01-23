
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DailySensorData {
//_value contains all the average hours values in the last 24 hours
  var _values = ValueNotifier<List<double>>([]);
  var _hour;
//Constructor
  DailySensorData() {
    this._hour = 0;
    for (var i = 0; i < 24; i++) {
      this._values.value.add(0.0);
    }
  }
//Getter
  ValueListenable<List<double>> getValues() {
    return _values;
  }
//Getter of a specific hour value
  double getValue(int pos) {
    return _values.value[pos];
  }
//Gets the summation of all the value in the last 24h (useful for make the average value)
  double getSum() {
    double sum = 0;
    for(int i=0; i<_values.value.length; i++) {
      sum = sum + _values.value[i];
    }
    return sum;
  }
//it gets the actual hour and makes the average
   void setDataAverage(double average, int hour)  {
    if(_hour != hour){
      _hour = hour;
      this._values.value[hour] = 0.0;
    }
    this._values.value[hour] = this._values.value[hour] == 0.0 ? average : (this._values.value[hour] + average) / 2;
  }

}

