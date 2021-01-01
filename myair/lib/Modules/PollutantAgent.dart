
class PollutantAgent {

  double _pm10_limit;
  double _pm25_limit;
  double _no2_limit;
  double _so2_limit;
  double _o3_limit;
  double _co_limit;

  double _pm10_value;
  double _pm25_value;
  double _no2_value;
  double _so2_value;
  double _o3_value;
  double _co_value;

  double _pm10_bck;
  double _pm25_bck;
  double _no2_bck;
  double _so2_bck;
  double _o3_bck;
  double _co_bck;

  int day;
  int hour;

  PollutantAgent(double pm10_limit, double pm25_limit, double no2_limit, double so2_limit, double o3_limit, double co_limit) {
    this._pm10_limit = pm10_limit;
    this._pm25_limit = pm25_limit;
    this._no2_limit = no2_limit;
    this._so2_limit = so2_limit;
    this._o3_limit = o3_limit;
    this._co_limit = co_limit;
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

  void set_values(double pm10, double pm25, double no2, double so2, double o3, double co) {
    int hour;
    int day;

    hour = DateTime.now().hour;
    day = DateTime.now().day;

    if (day != this.day) {
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

      this.day = day;
    }

    // Index calculation for each sensor every hour
    if (hour != this.hour ) {
      double value;

      value = set_pm25(pm25);
      _pm25_value = (_pm25_value + value) / 2;

      value = set_pm10(pm10);
      _pm10_value = (_pm10_value + value) / 2;

      value = set_no2(no2);
      _no2_value = (_no2_value + value) / 2;

      value = set_so2(so2);
      _so2_value = (_so2_value + value) / 2;

      value = set_o3(o3);
      _o3_value = (_o3_value + value) / 2;

      value = set_co(co);
      _co_value = (_co_value + value) / 2;

      this.hour = hour;
    }

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
    } else if ((sensorvalue>25) && (sensorvalue <=30)) {
      index = 0.4; // Poor
    } else if ((sensorvalue>30) && (sensorvalue <=800)) {
      index = 0.2; // Very poor
    } else index = 0.0;

    return index;
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

    // Index calculation
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
    if ((sensorvalue>=0) && (sensorvalue <=10)) {
      index = 1.0; // Very good
    } else if ((sensorvalue>10) && (sensorvalue <=20)) {
      index = 0.8; // Good
    } else if ((sensorvalue>20) && (sensorvalue <=30)) {
      index = 0.6; // acceptable
    } else if ((sensorvalue>30) && (sensorvalue <=40)) {
      index = 0.4; // Poor
    } else if ((sensorvalue>40) && (sensorvalue <=50)) {
      index = 0.2; // Very poor
    } else index = 0.0;

    return index;
  }
}

