
import 'package:myair/main.dart';

class PollutantAgent {
  //Average of the daily aqi of the day until an hour
  double _pm10_value;
  double _pm25_value;
  double _no2_value;
  double _so2_value;
  double _o3_value;
  double _co_value;
  //Average of the last daily aqi of the day until an hour
  double _pm10_bck;
  double _pm25_bck;
  double _no2_bck;
  double _so2_bck;
  double _o3_bck;
  double _co_bck;
  //Summation of all misuration until this hour
  double _pm10_rw;
  double _pm25_rw;
  double _no2_rw;
  double _so2_rw;
  double _o3_rw;
  double _co_rw;
  //Notification's limit of the reward
  double _pm10_limit;
  double _pm25_limit;
  double _no2_limit;
  double _so2_limit;
  double _o3_limit;
  double _co_limit;
  //Limit reached for the reward
  bool _pm10_notify;
  bool _pm25_notify;
  bool _no2_notify;
  bool _so2_notify;
  bool _o3_notify;
  bool _co_notify;
  //Notification already sended for this goal (in order to avoid push notification spam)
  bool _pm10_already_notify;
  bool _pm25_already_notify;
  bool _no2_already_notify;
  bool _so2_already_notify;
  bool _o3_already_notify;
  bool _co_already_notify;
  //Actual day and hour
  int day;
  int hour;
  static PollutantAgent _pollutantAgent;
  PollutantAgent._createInstance() ;

  //Constructor
  factory PollutantAgent() {
    if (_pollutantAgent == null) {
      // this is execute only once, singleton object
      _pollutantAgent = PollutantAgent._createInstance();
    }
    return _pollutantAgent;
  }

//Initialization of the Singleton
  initialize(double pm10_limit, double pm25_limit, double no2_limit, double so2_limit, double o3_limit, double co_limit) {
    this._pm10_limit = pm10_limit;
    this._pm25_limit = pm25_limit;
    this._no2_limit = no2_limit;
    this._so2_limit = so2_limit;
    this._o3_limit = o3_limit;
    this._co_limit = co_limit;

    this.hour=0;
    this.day=0;

    this._pm10_value=0.0;
    this._pm25_value=0.0;
    this._no2_value=0.0;
    this._so2_value=0.0;
    this._o3_value=0.0;
    this._co_value=0.0;

    this._pm10_rw=0.0;
    this._pm25_rw=0.0;
    this._no2_rw=0.0;
    this._so2_rw=0.0;
    this._o3_rw=0.0;
    this._co_rw=0.0;

    this._pm10_already_notify = false;
    this._pm25_already_notify = false;
    this._no2_already_notify = false;
    this._so2_already_notify= false;
    this._o3_already_notify= false;
    this._co_already_notify= false;

    this._pm10_notify=false;
    this._pm25_notify=false;
    this._no2_notify=false;
    this._so2_notify=false;
    this._o3_notify=false;
    this._co_notify=false;
  }

  //Getter
  double get_pm10_limit() {
    return _pm10_limit;
  }
  double get_pm25_limit() {
    return _pm25_limit;
  }
  double get_no2_limit() {
    return _no2_limit;
  }
  double get_so2_limit() {
    return _so2_limit;
  }
  double get_o3_limit() {
    return _o3_limit;
  }
  double get_co_limit() {
    return _co_limit;
  }
  double get_pm10_value() {
    return _pm10_value;
  }
  double get_pm25_value() {
    return _pm25_value;
  }
  double get_no2_value() {
    return _no2_value;
  }
  double get_so2_value() {
    return _so2_value;
  }
  double get_o3_value() {
    return _o3_value;
  }
  double get_co_value() {
    return _co_value;
  }
  double get_pm10_bck() {
    return _pm10_bck;
  }
  double get_pm25_bck() {
    return _pm25_bck;
  }
  double get_no2_bck() {
    return _no2_bck;
  }
  double get_so2_bck() {
    return _so2_bck;
  }
  double get_o3_bck() {
    return _o3_bck;
  }
  double get_co_bck() {
    return _co_bck;
  }
  double get_pm10_rw() {
    return _pm10_rw;
  }
  double get_pm25_rw() {
    return _pm25_rw;
  }
  double get_no2_rw() {
    return _no2_rw;
  }
  double get_so2_rw() {
    return _so2_rw;
  }
  double get_o3_rw() {
    return _o3_rw;
  }
  double get_co_rw() {
    return _co_rw;
  }
  // Return the notify status and reset it
  bool get_pm10_notify() {
    bool value = false;
    if(!_pm10_already_notify) {
      value = this._pm10_notify;
      if(value)_pm10_already_notify = true;
    }
    return value;
  }
  // Return the notify status and reset it
  bool get_pm25_notify() {
    bool value = false;
    if(!_pm25_already_notify) {
      value = this._pm25_notify;
      if(value)  _pm25_already_notify = true;
    }

    return value;
  }
  // Return the notify status and reset it
  bool get_no2_notify() {
    bool value = false;
    if(!_no2_already_notify) {
      value = this._no2_notify;
      if(value) _no2_already_notify = true;
    }
    return value;
  }
  // Return the notify status and reset it
  bool get_so2_notify() {
    bool value = false;
    if(!_so2_already_notify) {
      value = this._so2_notify;
      if(value)  _so2_already_notify = true;
    }
    return value;
  }
  // Return the notify status and reset it
  bool get_o3_notify() {
    bool value = false;
    if(!_o3_already_notify) {
      value = this._o3_notify;
      if(value) _o3_already_notify = true;
    }
    return value;
  }
  // Return the notify status and reset it
  bool get_co_notify() {
    bool value = false;
    if(!_co_already_notify) {
      value = this._co_notify;
      if(value) _co_already_notify = true;
    }
    return value;
  }

  //Setter
  void set_values(int hour, int day, double pm10, double pm25, double no2, double so2, double o3, double co) {

    //Starting a new day
    if (day != this.day) {
      DateTime.now().weekday == 1 ? actualUser.reset() : null;

      _pm10_bck = _pm10_value;
      _pm25_bck = _pm25_value;
      _no2_bck = _no2_value;
      _so2_bck = _so2_value;
      _o3_bck = _o3_value;
      _co_bck = _co_value;

      _pm10_value = 0;
      _pm25_value = 0;
      _no2_value = 0;
      _so2_value = 0;
      _o3_value = 0;
      _co_value = 0;

      _pm10_rw = 0;
      _pm25_rw = 0;
      _no2_rw = 0;
      _so2_rw = 0;
      _o3_rw = 0;
      _co_rw = 0;

      this._pm10_already_notify = false;
      this._pm25_already_notify = false;
      this._no2_already_notify = false;
      this._so2_already_notify= false;
      this._o3_already_notify= false;
      this._co_already_notify= false;

      _pm10_notify = false;
      _pm25_notify = false;
      _no2_notify = false;
      _so2_notify = false;
      _o3_notify = false;
      _co_notify = false;

      this.day = day;
    }

    // Index calculation for each sensor every hour
    if (hour != this.hour ) {
      double value;

      value = set_pm25(pm25);
      if(_pm25_value == 0) {
        _pm25_value = value;
      } else {
        _pm25_value = (_pm25_value + value) / 2;
      }

      value = set_pm10(pm10);
      if(_pm10_value == 0) {
        _pm10_value = value;
      } else {
        _pm10_value = (_pm10_value + value) / 2;
      }

      value = set_no2(no2);
      if(_no2_value == 0) {
        _no2_value = value;
      } else {
        _no2_value = (_no2_value + value) / 2;
      }

      value = set_so2(so2);
      if(_so2_value == 0) {
        _so2_value = value;
      } else {
        _so2_value = (_so2_value + value) / 2;
      }

      value = set_o3(o3);
      if(_o3_value == 0) {
        _o3_value = value;
      } else {
        _o3_value = (_o3_value + value) / 2;
      }

      value = set_co(co);
      if(_co_value == 0) {
        _co_value = value;
      } else {
        _co_value = (_co_value + value) / 2;
      }

      this.hour = hour;
    }

    // Reward calculus done every hour
    setSensorsRW();
  }
  // Sensors reward calculus
  void setSensorsRW() {

    this._pm10_rw = this._pm10_rw + this._pm10_value;
    this._pm25_rw = this._pm25_rw + this._pm25_value;
    this._no2_rw = this._no2_rw + this._no2_value;
    this._so2_rw = this._so2_rw + this._so2_value;
    this._o3_rw = this._o3_rw + this._o3_value;
    this._co_rw = this._co_rw + this._co_value;

    // Notify if a cycle has been done

      if (this._pm10_rw >= _pm10_limit) {
        this._pm10_rw = _pm10_limit;
        if(!_pm10_notify) {  _pm10_notify = true;
      }
    }
    // Notify if a cycle has been done

      if (this._pm25_rw >= _pm25_limit) {
        this._pm25_rw = _pm25_limit;
        if(!_pm25_notify)  { _pm25_notify = true;
      }
    }

    // Notify if a cycle has been done

      if (this._no2_rw >= _no2_limit) {
        this._no2_rw = _no2_limit;
        if(!_no2_notify)   {    _no2_notify = true;
      }
    }

    // Notify if a cycle has been done

      if (this._so2_rw >= _so2_limit) {
        this._so2_rw = _so2_limit;
        if(!_so2_notify)   { _so2_notify = true;
      }
    }
    // Notify if a cycle has been done
      if (this._o3_rw >= _o3_limit) {
        this._o3_rw = _o3_limit;

        if(!_o3_notify)   { _o3_notify = true;
      }
    }

    // Notify if a cycle has been done

      if (this._co_rw >= _co_limit) {
        this._co_rw = _co_limit;
        if(_co_notify)  {_co_notify = true;
      }
    }
  }
  // pm10 index update
  double set_pm10(double sensorvalue) {
    double index;

    // Index calculation
    if ((sensorvalue>=0) && (sensorvalue <=20)) {
      index = 1.0; // Very good
    } else if ((sensorvalue>20) && (sensorvalue <=35)) {
      index = 0.8; // Good
    } else if ((sensorvalue>35) && (sensorvalue <=50)) {
      index = 0.6; // acceptable
    } else if ((sensorvalue>50) && (sensorvalue <=100)) {
      index = 0.4; // Poor
    } else if ((sensorvalue>100) && (sensorvalue <=1200)) {
      index = 0.2; // Very poor
    } else index = 0.0;

    return index;
  }
  // pm25 index update
  double set_pm25(double sensorvalue) {
    double index;

    // Index calculation
    if ((sensorvalue>=0) && (sensorvalue <=10)) {
      index = 1.0; // Very good
    } else if ((sensorvalue>10) && (sensorvalue <=20)) {
      index = 0.8; // Good
    } else if ((sensorvalue>20) && (sensorvalue <=25)) {
      index = 0.6; // acceptable
    } else if ((sensorvalue>25) && (sensorvalue <=50)) {
      index = 0.4; // Poor
    } else if ((sensorvalue>50) && (sensorvalue <=800)) {
      index = 0.2; // Very poor
    } else index = 0.0;

    return index;
  }
  // no2 index update
  double set_no2(double sensorvalue) {
    double index;

    // Index calculation
    if ((sensorvalue>=0) && (sensorvalue <=40)) {
      index = 1.0; // Very good
    } else if ((sensorvalue>40) && (sensorvalue <=100)) {
      index = 0.8; // Good
    } else if ((sensorvalue>100) && (sensorvalue <=200)) {
      index = 0.6; // acceptable
    } else if ((sensorvalue>200) && (sensorvalue <=400)) {
      index = 0.4; // Poor
    } else if ((sensorvalue>400) && (sensorvalue <=1000)) {
      index = 0.2; // Very poor
    } else index = 0.0;

    return index;
  }
  // o3 index update
  double set_o3(double sensorvalue) {
    double index;

    // Index calculation test
    if ((sensorvalue>=0) && (sensorvalue <=80)) {
      index = 1.0; // Very good
    } else if ((sensorvalue>80) && (sensorvalue <=120)) {
      index = 0.8; // Good
    } else if ((sensorvalue>120) && (sensorvalue <=180)) {
      index = 0.6; // acceptable
    } else if ((sensorvalue>180) && (sensorvalue <=240)) {
      index = 0.4; // Poor
    } else if ((sensorvalue>240) && (sensorvalue <=600)) {
      index = 0.2; // Very poor
    } else index = 0.0;

    return index;
  }
  // so2 index update
  double set_so2(double sensorvalue) {
    double index;

    // Index calculation
    if ((sensorvalue>=0) && (sensorvalue <=100)) {
      index = 1.0; // Very good
    } else if ((sensorvalue>100) && (sensorvalue <=200)) {
      index = 0.8; // Good
    } else if ((sensorvalue>200) && (sensorvalue <=350)) {
      index = 0.6; // acceptable
    } else if ((sensorvalue>350) && (sensorvalue <=500)) {
      index = 0.4; // Poor
    } else if ((sensorvalue>500) && (sensorvalue <=1250)) {
      index = 0.2; // Very poor
    } else index = 0.0;

    return index;
  }
  // co index update
  double set_co(double sensorvalue) {
    double index;

    // Index calculation
    if ((sensorvalue>=0) && (sensorvalue <=4)) {
      index = 1.0; // Very good
    } else if ((sensorvalue>4) && (sensorvalue <=8)) {
      index = 0.8; // Good
    } else if ((sensorvalue>8) && (sensorvalue <=10)) {
      index = 0.6; // acceptable
    } else if ((sensorvalue>10) && (sensorvalue <=20)) {
      index = 0.4; // Poor
    } else if ((sensorvalue>20) && (sensorvalue <=50)) {
      index = 0.2; // Very poor
    } else index = 0.0;

    return index;
  }

  //Calculate the AirQualityIndex based on the reward
  int getAqi(double pm10, double pm25, double no2, double so2, double o3, double co){
    var average = (6 - set_pm10(pm10) - set_pm25(pm25) - set_no2(no2) - set_so2(so2) -  set_o3(o3) - set_co(co))/6;
    average = average * 500;
    return average.round();
  }
}

