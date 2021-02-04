import 'package:intl/intl.dart';
import 'package:myair/Services/Database_service/DatabaseHelper.dart';
import 'package:myair/Services/Database_service/FirebaseDatabaseHelper.dart';

class UserAccount {

  String firebaseId;
  String firstName;
  String lastName;
  String email;
  String password;
  String img;
  List<int> notificationLimits;
  bool notificationSend;
  bool notificationReward;
  String lastLog; // Date in which the challenge of log 7 days in a row is started

  //Last login made
  int counter;
  int hourSafe;
  bool weeklyMissionFailed;

  //Mapping for FireBase
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

  //Constructor
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
    this.checkWeeklyChallenges();
  }

  //Setter of the firebase id(we make it subsequently because we had to first create the user, save it and only after that we can get the Key)
  setFId(String id) {
    firebaseId = id;
  }

  //Mapping for local database
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

  //Mapping when i retrieve the user from the local database
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

  //Setter for the notifications limits (customized by the user in the Setting Page)
  void setLimits(List<int> list) {
    this.notificationLimits = list;
  }

  //Setter for the notifications(if we can send it or not), Setting Page
  void setNotification(bool notificationSend, bool notificationReward) {
    this.notificationSend = notificationSend;
    this.notificationReward = notificationReward;
  }

  //Setter for what concern the weekly challenges of the user, used in RewardPage
  void setWeeklyChallenges(String lastLog, int hourSafe, bool wf, int counter) {
    this.lastLog = lastLog;
    this.hourSafe = hourSafe;
    this.weeklyMissionFailed = wf;
    this.counter = counter;
  }

  //Check the situation of the weekly challenges
  Future<void> checkWeeklyChallenges() async {
    //Split the last login of the user to have day and month -> lastLog has the format MM-dd
    var firstLog = lastLog.split("-");
    //Create a DateTime type of the last user login
    DateTime date = DateTime(DateTime.now().year, int.parse(firstLog[0]), int.parse(firstLog[1]));
    //Get the difference between actual date and the last login date
    var streak = DateTime.now().difference(date).inDays;
    //If the IF-STATEMENT is true means that the user has log in yesterday
    if(counter == streak - 1) {
      counter = 1 + streak;
    }else{counter = 1; lastLog = DateFormat('MM-dd').format(DateTime.now());} // Otherwise reset the challenge
    //Update data
    await DatabaseHelper().deleteUser();
    await DatabaseHelper().insertUser(this);
    FirebaseDatabaseHelper().updateUser();
  }

  //Update the challenge in which the user stays 100h in a safety place
  Future<void> sethourSafe(int i) async {
    if(this.hourSafe<=3000){
      this.hourSafe += i;
      await DatabaseHelper().deleteUser();
      await DatabaseHelper().insertUser(this);
      FirebaseDatabaseHelper().updateUser();
    }
  }

  //Start of the new week
  reset() {
    this.hourSafe = 0;
    this.weeklyMissionFailed = true;
  }

  //Update Of the user image in all the databases
  Future<void> updateUserImg(String img) async {
    this.img = img;
    await DatabaseHelper().setImg(this.email,img);
    FirebaseDatabaseHelper().updateUser();
  }

  //Update Of the user in all the databases
  Future<void> updateUser() async {
    await DatabaseHelper().deleteUser();
    await DatabaseHelper().insertUser(this);
    FirebaseDatabaseHelper().updateUser();
  }
}