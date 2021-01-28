import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myair/Modules/UserAccount.dart';
import 'package:myair/Services/Database_service/FirebaseDatabaseHelper.dart';

class RegistrationForm extends StatefulWidget {
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController firstController = new TextEditingController();
  TextEditingController lastController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  var error = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Padding(padding: const EdgeInsets.only(left:8.0,right:8.0,bottom:8.0),child: FractionallySizedBox(widthFactor:1/2,child: FittedBox(fit: BoxFit.fitHeight,child: Text("Insert your name:",style: TextStyle(color: Colors.white),))),),
        TextField(
          keyboardType: TextInputType.text,
          controller: firstController,
          decoration: InputDecoration(
              isDense: true,                      // Added this
              contentPadding: EdgeInsets.all(8),
              filled: true,
              fillColor: Colors.white,
              hintText: "Firsname",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        ),
        Padding(padding: const EdgeInsets.all(8.0),child: FractionallySizedBox(widthFactor:1/2,child: FittedBox(fit: BoxFit.fitHeight,child: Text("Insert your surname:",style: TextStyle(color: Colors.white),))),),

        TextField(
          controller: lastController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              isDense: true,                      // Added this
              contentPadding: EdgeInsets.all(8),
              filled: true,
              fillColor: Colors.white,
              hintText: "Lastname",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        ),
        Padding(padding: const EdgeInsets.all(8.0),child: FractionallySizedBox(widthFactor:1/2,child: FittedBox(fit: BoxFit.fitHeight,child: Text("Insert your email:",style: TextStyle(color: Colors.white),))),),

        Stack(
          children: [
            new TextField(
              controller: emailController,
              keyboardType: TextInputType.text,
              enableSuggestions: false,
              autocorrect: false,
              decoration: error
                  ? new InputDecoration(
                isDense: true,                      // Added this
                contentPadding: EdgeInsets.all(8),
                filled: true,
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      hintText: 'Email',
                      errorText: 'Email already exists',
                    )
                  : new InputDecoration(
                isDense: true,                      // Added this
                contentPadding: EdgeInsets.all(8),
                filled: true,
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      hintText: 'Email',
                    ),
            ),
          ],
        ),
        Padding(padding: const EdgeInsets.all(8.0),child: FractionallySizedBox(widthFactor:1/2,child: FittedBox(fit: BoxFit.fitHeight,child: Text("Insert your password:",style: TextStyle(color: Colors.white),))),),

        TextField(
          controller: passController,
          keyboardType: TextInputType.text,
          enableSuggestions: false,
          autocorrect: false,
          obscureText: true,
          decoration: InputDecoration(
              filled: true,
              isDense: true,                      // Added this
              contentPadding: EdgeInsets.all(8),
              fillColor: Colors.white,
              hintText: "Password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        ),
        SizedBox(height: 25.0,),
        Container(
          child: Center(
            child: GestureDetector(
              onTap: () async {
                await FirebaseDatabaseHelper().saveUser(new UserAccount(
                        firstController.text,
                        lastController.text,
                        emailController.text,
                        passController.text,
                        '',
                        [100, 50, 400, 500, 240, 10],
                        true,
                        true,
                        DateFormat('MM-dd').format(DateTime.now()),
                        0,
                        true,
                        0))
                    ? Navigator.pushReplacementNamed(context, '/HomePage')
                    : setState(() {
                        error = true;
                      });
              },

              child: Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 3),
                  color: Theme.of(context).backgroundColor,
                ),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      'SignUp',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
