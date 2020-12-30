import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myair/Views/home_page.dart';
import 'package:myair/Widgets/Opening_page_widgets/logo_widget.dart';
import 'package:myair/Services/Database_service/firebase_database_user.dart';
import 'package:myair/main.dart';
import 'package:myair/Modules/UserAccount.dart';
//TODO make registration page
class RegistrationPage extends StatefulWidget{
  _RegistrationPage createState() =>  _RegistrationPage();

}
class _RegistrationPage extends State<RegistrationPage>{
  @override
  TextEditingController emailController = new TextEditingController();
  TextEditingController firstController = new TextEditingController();
  TextEditingController lastController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  var error = false;
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: false,
    body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_background.png"),
            fit: BoxFit.cover,
          ),
        ),

        child:Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 10, right: MediaQuery.of(context).size.width / 10,bottom: MediaQuery.of(context).size.width / 10, top: MediaQuery.of(context).size.width / 8),
          child: Card(
            elevation: 1.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/20),
            ),
            color: Colors.transparent.withOpacity(0.5),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LogoImport(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  Expanded(flex: 2,child:
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
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
                            /*    TextField(
                                  controller: emailController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(

                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "Email",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          borderSide: new BorderSide(color: Colors.red) )),
                                ),*/
                                new TextField(
                                  controller: emailController,
                                  keyboardType: TextInputType.text,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration:error ? new InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                      hintText: 'Email',
                                      errorText: 'Email already exists',
                                      //labelText: 'Email',

                                ): new InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                    hintText: 'Email',
                                   // labelText: 'Email',

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
                                      logged = true;
                                      FirebaseDb_gesture d = FirebaseDb_gesture();
                                      var b = await d.saveUser(new userAccount(firstController.text,lastController.text,emailController.text,passController.text,''));
                                      b ?
                                      Navigator.pushReplacementNamed(context, '/HomePage')
                                      :
                                      setState(() {
                                        error = true;
                                      });

                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(MediaQuery.of(context).size.width/30),
                                      //  margin: EdgeInsets.symmetric( ).copyWith(),
                                      // padding: EdgeInsets.symmetric( ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 3),
                                        color: Theme.of(context).backgroundColor,
                                      ),

                                      child: Center(
                                        child: Text(
                                          'SignUp',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                        ),
                                      ),
                                          //Center(child: FittedBox(fit: BoxFit.fitHeight,child: Text("Sign up"), )),

                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
    ),
  );
  }

}