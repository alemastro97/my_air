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
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  //if the credential are wrong the textView become with a decoration ErrorText
                  decoration: errorCredentials
                      ? new InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          hintText: 'Email',
                          errorText: "")
                      : new InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          hintText: 'Email',
                        ),
                ),
              ),
            ),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passController,
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: errorCredentials
                    ? new InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        hintText: 'Password',
                        errorText: 'Email or Password doesn\'t exist',
                      )
                    : new InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        hintText: 'Password',
                      ),
              ),
            )),
            Flexible(
              child: Container(
                child: Center(
                  child: FractionallySizedBox(
                    heightFactor: 2 / 3,
                    widthFactor: 2 / 3,
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
                            MediaQuery.of(context).size.width / 30),
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
            ),
          ],
        ),
      ),
    );
  }
}
