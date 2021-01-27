

import 'package:flutter/cupertino.dart';

import 'InfoPollution.dart';

class ActualValue {
  //actual values
  ValueNotifier<List<ValueNotifier<InfoPollution>>> _actualData;
  //_dailyUnitData instance, we developed it as a Singleton
  static ActualValue _actualValue;
  ActualValue._createInstance() ;

  //Constructor
  factory ActualValue() {
    if ( _actualValue == null) {
      // this is execute only once, singleton object
      _actualValue = ActualValue._createInstance();
    }
    return  _actualValue;
  }
  //Initialization of the arrays
  void initializeValues() {
    _actualData =  ValueNotifier<List<ValueNotifier<InfoPollution>>>(
        [
          ValueNotifier(InfoPollution('PM10', amount: 23.0)),
          ValueNotifier(InfoPollution('PM2.5', amount: 23.0)),
          ValueNotifier(InfoPollution('NO2', amount: 37.0)),
          ValueNotifier(InfoPollution('SO2', amount: 15.0)),
          ValueNotifier(InfoPollution('O3', amount: 17.0)),
          ValueNotifier(InfoPollution('CO', amount: 12.0))
        ]
    );
  }

  ValueNotifier<List<ValueNotifier<InfoPollution>>> getActualData(){
    return _actualData;
  }

  void setActualDataById(int index, InfoPollution p){
    _actualData.value.elementAt(index).value = p;
  }

}