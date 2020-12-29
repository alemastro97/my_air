import 'package:firebase_auth/firebase_auth.dart';

class userAccount {
  //final user = FirebaseAuth.instance.currentUser;

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

}


