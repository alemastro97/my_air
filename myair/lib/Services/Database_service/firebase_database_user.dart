import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/UserAccount.dart';
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
  DatabaseReference saveUser(userAccount u)  {
    var dbRef = databaseReference.child('users/').push();
    dbRef.set(u.toJson());

    return dbRef;
  }
}

var lists = [];
class UserWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: databaseReference.once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.hasData) {
            lists.clear();
            Map<dynamic, dynamic> values = snapshot.data.value;
            values.forEach((key, values) {
              lists.add(values);
            });
            return new ListView.builder(
                shrinkWrap: true,
                itemCount: lists.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Name: " + lists[index]["firstname"]),
                        Text("Age: "+ lists[index]["lastname"]),
                        Text("Type: " +lists[index]["email"]),
                      ],
                    ),
                  );
                });
          }
          return CircularProgressIndicator();
        });
  }

}
