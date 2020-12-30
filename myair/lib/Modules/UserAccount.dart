import 'package:firebase_auth/firebase_auth.dart';

class userAccount {
  //final user = FirebaseAuth.instance.currentUser;
  String firebaseId;
  String firstName;
  String lastName;
  String email;
  String password;
  String img;

 // final User userdu;
 // userAccount(this.userdu);
  Map<String, dynamic> toJson(){
    return{
      "firstname" : this.firstName,
      "lastName" : this.lastName,
      "email" : this.email,
      "password" : this.password,
      "img" : this.img,
    };
  }

  userAccount(String firstName,String lastName,String email, String password,String img){
    this.firstName = firstName;
    this.lastName = lastName;
    this. email = email;
    this.password = password;
    this.img = img;
  }

  setFId(String id){firebaseId = id;}
  Map<String, dynamic> toMap() {


      var map = Map<String, dynamic>();

      map['firstname'] = firstName;
      map['lastname'] = lastName;
      map['email'] = email;
      map['password'] = password;
      map['image'] = img;
      map['firebaseId'] = firebaseId;

      return map;

  }
  fromMapObject(Map<String, dynamic> map) {
    firebaseId = map['firebaseId'];
    firstName = map['firstname'];
    lastName = map['lastname'];
    email = map['email'];
    password = map['password'];
    img = map['image'];

  }


}


