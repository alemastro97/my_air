import 'package:firebase_database/firebase_database.dart';
import 'package:myair/Modules/UserAccount.dart';
import 'package:myair/Services/Database_service/DatabaseHelper.dart';
import 'package:myair/main.dart';

final FirebaseDatabase db = new FirebaseDatabase(); //.child('users');
final databaseReference = db.reference();

class FirebaseDatabaseHelper{
  static FirebaseDatabaseHelper _firebaseDatabaseGesture; //Singleton DatabaseHelper

  FirebaseDatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper;

  factory FirebaseDatabaseHelper() {

    if (_firebaseDatabaseGesture == null) {
      _firebaseDatabaseGesture = FirebaseDatabaseHelper._createInstance(); // this is execute only once, singleton object
    }
    return _firebaseDatabaseGesture;
  }

  Future<bool> saveUser(UserAccount u)  async {
    bool present = false;
    var dbRefCheck = databaseReference.child('users/');
    DataSnapshot us = await dbRefCheck.once();
    Map<dynamic,dynamic> values = us.value;

    if(values != null)
    {
      values.forEach((key, value) {
        if (value["email"] == u.email) present = true;
      });
    }

    if (!present) {
      var dbRef =  dbRefCheck.push();
      await dbRef.set(u.toJson());
      DataSnapshot snapshot =  await dbRefCheck.orderByChild("email").equalTo(u.email).once();
      Map<dynamic, dynamic> values=snapshot.value;
      values.forEach((key, value) {
        u.setFId(key);
      });
      DatabaseHelper d = DatabaseHelper();
      var x = await d.getCountUser();
      if(x == 0 ) {
        d.insertUser(u);
      }
      d.getUser();

      actualUser = u;

      return true;
    }
    return false;
  }

  // Save the google account of the user
  Future<void> saveGoogleUser(UserAccount u)async{
    bool present = false;
    var dbRefCheck = databaseReference.child('users/');
    DataSnapshot us = await dbRefCheck.once();
    Map<dynamic,dynamic> values = us.value;
    if(values != null)
    {
      values.forEach((key, value) {
        if (value["email"] == u.email) {
          present = true;
          u.setFId(key);
          u.setLimits([
            (value['pm10']),
            (value['pm25']),
            (value['no2']),
            (value['so2']),
            (value['o3']),
            (value['co'])
          ]);
          u.setNotification(value['notificationSend'], value['notificationReward']);
          u.setWeeklyChallenges( value['lastLog'],
              value['hourSafe'],
              value['weeklyMissionFailed'],value['counter']);
        }
      });
    }
    if (!present) {
      var dbRef =  dbRefCheck.push();
      await dbRef.set(u.toJson());
      DataSnapshot snapshot =  await dbRefCheck.orderByChild("email").equalTo(u.email).once();
      Map<dynamic, dynamic> values=snapshot.value;
      values.forEach((key, value) {
        u.setFId(key);
      });}

    DatabaseHelper d = DatabaseHelper();
    var x = await d.getCountUser();

    if(x == 0 ) {
      d.insertUser(u);
    }
    print("Salvato");
    d.getUser();

    actualUser = u;

  }

  // Login of the user checking the existance of the account in the db
  Future<bool> logUser(String email, String pwd) async {
    bool present = false;
    var dbRefCheck = databaseReference.child('users/');
    DataSnapshot us = await dbRefCheck.once();
    Map<dynamic,dynamic> values = us.value;
    if (values != null){
      values.forEach((key, value) {
        if (value["email"] == email && value["password"] == pwd) {
          present = true;
          UserAccount u = new UserAccount(value['firstname'], value['lastname'],
              value['email'], value['password'], value['img'], [
            (value['pm10']),
           (value['pm25']),
            (value['no2']),
            (value['so2']),
            (value['o3']),
            (value['co'])
          ],
            (value['notificationSend']),
            (value['notificationReward']),
              value['lastLog'],
              value['hourSafe'],
              value['weeklyMissionFailed'],
          value['counter']);
          u.setFId(key.toString());
          DatabaseHelper d = DatabaseHelper();
          d.insertUser(u);
          print(u.email);
          print(u.firstName);
          actualUser = u;
          print(actualUser.firstName);
        }
      });
    }
    return present;
  }

  Future<bool> updateUser() async{
    var dbRefCheck = databaseReference.child('users/');
    await dbRefCheck.child(actualUser.firebaseId).set(actualUser.toJson());
  }

  Future<String> getShadowUserAccount() async {
    String credentials ="";
    var dbRefCheck = databaseReference.child('systemCredentials/');
    DataSnapshot us = await dbRefCheck.once();
    Map<dynamic,dynamic> values = us.value;
    if (values != null){
      values.forEach((key, value) {
        credentials = value['email'] + "/" + value['password'];
      });
    }
    return credentials;
  }
}