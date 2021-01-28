import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Services/Database_service/FirebaseDatabaseHelper.dart';

class LoginForm extends StatefulWidget {
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController =
      new TextEditingController(); //Controller to take the text in the TextView Of the email
  TextEditingController passController =
      new TextEditingController(); //Controller to take the text in the TextView Of the password

  var errorCredentials = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:8.0,right:8.0,left:8.0),
      child: ListView(

        shrinkWrap: true,
       children:<Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: <Widget>[
          Padding(padding: const EdgeInsets.only(left:8.0,right:8.0),child: FractionallySizedBox(widthFactor:1/2,child: FittedBox(fit: BoxFit.fitHeight,child: Text("Insert email:",style: TextStyle(color: Colors.white),))),),
          Padding(
            padding: const EdgeInsets.only(right:8.0,left: 8.0),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.text,
              //if the credential are wrong the textView become with a decoration ErrorText
              decoration: errorCredentials
                  ? new InputDecoration(
                  isDense: true,                      // Added this
                      filled: true,
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      hintText: 'Email',
                      errorText: "")
                  : new InputDecoration(
                isDense: true,                      // Added this
               // contentPadding: EdgeInsets.all(8),
                      filled: true,
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      hintText: 'Email',
                    ),
            ),
          ),
          Padding(padding: const EdgeInsets.only(left:8.0,right:8.0),child: FractionallySizedBox(widthFactor:1/2,child: FittedBox(fit: BoxFit.fitHeight,child: Text("Insert password:",style: TextStyle(color: Colors.white),))),),

          Padding(
            padding: const EdgeInsets.only(right:8.0,left: 8.0, bottom: 8.0),
            child: TextFormField(
          controller: passController,
          enableSuggestions: false,
          autocorrect: false,
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: errorCredentials
              ? new InputDecoration(
            isDense: true,                      // Added this
          //  contentPadding: EdgeInsets.all(8),
                  filled: true,
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(10.0))),
                  hintText: 'Password',
                  errorText: 'Email or Password doesn\'t exist',
                )
              : new InputDecoration(
            isDense: true,                      // Added this
            //contentPadding: EdgeInsets.all(8),
                  filled: true,
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(10.0))),
                  hintText: 'Password',
                ),
            ),
          ),
          Container(
            child: Center(
              child: FractionallySizedBox(
               // heightFactor: 2 / 3,
             //   widthFactor: 2 / 3,
                child: GestureDetector(
                  onTap: () async {
                     await FirebaseDatabaseHelper() // Check if the credential are right on the Firebase Database
                        .logUser(emailController.text, passController.text)
                        ? Navigator.pushReplacementNamed(
                            context, '/HomePage')
                        : setState(() {
                            errorCredentials = true;
                          });
                  },
                  //Button of the login
                  child: Container(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width / 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 3),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          key: Key('LoginButton'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],)]
      ),
    );
  }
}
