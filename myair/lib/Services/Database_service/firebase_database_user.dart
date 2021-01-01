import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/UserAccount.dart';
import 'package:myair/Services/Database_service/database_helper.dart';
import 'package:myair/main.dart';
//import 'post.dart';

final FirebaseDatabase db = new FirebaseDatabase();//.child('users');
final databaseReference = db.reference();

class FirebaseDb_gesture{
  static FirebaseDb_gesture _FirebaseDb_gesture; //Singleton DatabaseHelper

  FirebaseDb_gesture._createInstance(); // Named constructor to create instance of DatabaseHelper;

  factory FirebaseDb_gesture() {

    if (_FirebaseDb_gesture == null) {
      _FirebaseDb_gesture = FirebaseDb_gesture._createInstance(); // this is execute only once, singleton object
    }
    return _FirebaseDb_gesture;
  }
  Future<bool> saveUser(userAccount u)  async {
    bool present = false;
    var dbRefCheck = databaseReference.child('users/');
    DataSnapshot us = await dbRefCheck.once();
    Map<dynamic,dynamic> values = us.value;
    values.forEach((key, value) {
      if(value["email"] == u.email)
        present = true;
    });
    if (!present) {
      var dbRef =  dbRefCheck.push();
     await dbRef.set(u.toJson());
     DataSnapshot snapshot =  await dbRefCheck.orderByChild("email").equalTo(u.email).once();
      Map<dynamic, dynamic> values=snapshot.value;
      values.forEach((key, value) {
        u.setFId(key);
      });
      DatabaseHelper d = DatabaseHelper();
      d.insertUser(u);
      actualUser = u;
      return true;
    }
    return false;
  }
  //TODO con logout cancellare user da database
  Future<bool> logUser(String email, String pwd) async {
    bool present = false;
    var dbRefCheck = databaseReference.child('users/');
    DataSnapshot us = await dbRefCheck.once();
    Map<dynamic,dynamic> values = us.value;
    values.forEach((key, value) {
      if(value["email"] == email && value["password"] == pwd) {
        present = true;
        userAccount u = new userAccount(value['firstname'],value['lastname'] , value['email'],value['password'],value['img']);
        u.setFId(key.toString());
        DatabaseHelper d = DatabaseHelper();
        d.insertUser(u);
        print(u.email);
        print(u.firstName);
        actualUser = u;
        print(actualUser.firstName);
      }
    });

    return present;
  }

  Future<bool> updateImage() async{
    var dbRefCheck = databaseReference.child('users/');
    await dbRefCheck.child(actualUser.firebaseId).set(actualUser.toJson());

  }

}
