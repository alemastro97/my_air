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
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: firstController,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Firsname",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)))),
          ),
        ),
        Expanded(
          flex: 1,
          child: TextField(
            controller: lastController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Lastname",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)))),
          ),
        ),
        Expanded(
          flex: 1,
          child: Stack(
            children: [
              new TextField(
                controller: emailController,
                keyboardType: TextInputType.text,
                enableSuggestions: false,
                autocorrect: false,
                decoration: error
                    ? new InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        hintText: 'Email',
                        errorText: 'Email already exists',
                      )
                    : new InputDecoration(
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
        ),
        Expanded(
          flex: 1,
          child: TextField(
            controller: passController,
            keyboardType: TextInputType.text,
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)))),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Center(
              child: FractionallySizedBox(
                heightFactor: 2 / 3,
                widthFactor: 2 / 3,
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
          ),
        ),
      ],
    );
  }
}
