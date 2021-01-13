import 'package:intl/intl.dart';
import 'package:myair/Services/Database_service/DatabaseHelper.dart';
import 'package:myair/Services/Database_service/FirebaseDatabaseHelper.dart';

class UserAccount {
  //final user = FirebaseAuth.instance.currentUser;
  String firebaseId;
  String firstName;
  String lastName;
  String email;
  String password;
  String img;
  List<int> notificationLimits;
  bool notificationSend;
  bool notificationReward;
  String lastLog;

  ///Last login made
  int counter;
  int hourSafe;
  bool weeklyMissionFailed;

  ///Mapping for FireBase
  Map<String, dynamic> toJson() {
    return {
      "firstname": this.firstName,
      "lastname": this.lastName,
      "email": this.email,
      "password": this.password,
      "img": this.img,
      "pm10": this.notificationLimits.elementAt(0),
      "pm25": notificationLimits.elementAt(1),
      "no2": notificationLimits.elementAt(2),
      "so2": notificationLimits.elementAt(3),
      "o3": notificationLimits.elementAt(4),
      "co": notificationLimits.elementAt(5),
      "notificationSend": this.notificationSend,
      "notificationReward": this.notificationReward,
      "lastLog": this.lastLog,
      "hourSafe": this.hourSafe,
      "weeklyMissionFailed": this.weeklyMissionFailed,
      "counter": this.counter
    };
  }

  UserAccount(String firstName, String lastName, String email, String password,
      String img, List<int> notificationLimits, bool notificationSend,
      bool notificationReward, String lastLog, int hourSafe,
      bool weeklyMissionFailed, int counter) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.password = password;
    this.img = img;
    this.notificationLimits = notificationLimits;
    this.notificationSend = notificationSend;
    this.notificationReward = notificationReward;
    this.lastLog = lastLog;
    this.hourSafe = hourSafe;
    this.weeklyMissionFailed = weeklyMissionFailed;
    this.counter = counter;
  }

  setFId(String id) {
    firebaseId = id;
  }

  ///Mapping for local database
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['userId'] = 1;
    map['firstname'] = firstName;
    map['lastname'] = lastName;
    map['email'] = email;
    map['password'] = password;
    map['image'] = img;
    map['firebaseId'] = firebaseId;
    map['pm10'] = notificationLimits.elementAt(0);
    map['pm25'] = notificationLimits.elementAt(1);
    map['no2'] = notificationLimits.elementAt(2);
    map['so2'] = notificationLimits.elementAt(3);
    map['o3'] = notificationLimits.elementAt(4);
    map['co'] = notificationLimits.elementAt(5);
    map['notificationSend'] = notificationSend.toString();
    map['notificationReward'] = notificationReward.toString();
    map['lastLog'] = this.lastLog;
    map['hourSafe'] = this.hourSafe.toString();
    map['weeklyMissionFailed'] = this.weeklyMissionFailed.toString();
    map['counter'] = this.counter.toString();
    return map;
  }

  ///Mapping when i retrieve the user from the local database
  fromMapObject(Map<String, dynamic> map) {
    firebaseId = map['firebaseId'];
    print(firebaseId);
    firstName = map['firstname'];
    print(firstName);
    lastName = map['lastname'];
    print(lastName);
    email = map['email'];
    print(email);
    password = map['password'];
    print(password);
    img = map['image'];
    print(img);
    notificationLimits = [
      int.parse(map['pm10']),
      int.parse(map['pm25']),
      int.parse(map['no2']),
      int.parse(map['so2']),
      int.parse(map['o3']),
      int.parse(map['co'])
    ];
    notificationSend = map["notificationSend"] == "true" ? true : false;
    notificationReward = map["notificationReward"] == "true" ? true : false;
    this.lastLog = map['lastLog'];
    this.hourSafe = int.parse(map['hourSafe']);
    this.weeklyMissionFailed =
    map['weeklyMissionFailed'] == "true" ? true : false;
    this.counter = int.parse(map['counter']);
  }

  void setLimits(List<int> list) {
    this.notificationLimits = list;
  }

  void setNotification(bool notificationSend, bool notificationReward) {
    this.notificationSend = notificationSend;
    this.notificationReward = notificationReward;
  }

  void setWeeklyChallenges(String lastLog, int hourSafe, bool wf, int counter) {
    this.lastLog = lastLog;
    this.hourSafe = hourSafe;
    this.weeklyMissionFailed = wf;
    this.counter = counter;
  }

  void checkWeeklyChallenges() {
    var firstLog = lastLog.split("-");
    DateTime date = DateTime(DateTime.now().year, int.parse(firstLog[0]), int.parse(firstLog[1]));
    var streak = DateTime.now().difference(date).inDays;
    if(counter == streak - 1) {
      counter = 1 + streak;
    }else{counter = 1; lastLog = DateFormat('MM-dd').format(DateTime.now());}
    DatabaseHelper().deleteUser();
    DatabaseHelper().insertUser(this);
    FirebaseDatabaseHelper().updateUser();
  }

  void sethourSafe(int i) {
    if(this.hourSafe<=3000){
      this.hourSafe += i;
      DatabaseHelper().deleteUser();
      DatabaseHelper().insertUser(this);
      FirebaseDatabaseHelper().updateUser();
    }
  }

  reset() {
    this.hourSafe = 0;
    this.weeklyMissionFailed = true;
  }
}