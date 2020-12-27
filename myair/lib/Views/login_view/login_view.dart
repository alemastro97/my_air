
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Widgets/Opening_page_widgets/logo_widget.dart';

import 'package:myair/main.dart';
//TODO make login page
class LoginPage extends StatelessWidget{
  @override
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
//TODO sistemare widgets
       child:Padding(
         padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 10, right: MediaQuery.of(context).size.width / 10,bottom: MediaQuery.of(context).size.width / 4, top: MediaQuery.of(context).size.width / 4),
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
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
                      Flexible(flex: 2,child:
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "Email",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                                ),
                              ),
                            ),
                            Flexible(child:Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                enableSuggestions: false,
                                autocorrect: false,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Password",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                              ),
                            )),

                            Flexible( child:Container(
                              child: Center(
                                child: FractionallySizedBox(
                                  heightFactor: 2 / 3,
                                  widthFactor: 2 / 3,
                                  child: GestureDetector(
                                    onTap: (){
                                      //TODO create control of the profile
                                      logged = true;
                                      Navigator.pushReplacementNamed(context, '/HomePage');
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
                                        child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Text(
                                            'Login',
                                            style: TextStyle(fontWeight: FontWeight.bold, ),
                                          ),
                                        ),
                                      ),
                                      //Center(child: FittedBox(fit: BoxFit.fitHeight,child: Text("Sign up"), )),

                                    ),
                                  ),
                                ),
                              ),
                            ),),
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
        ),
      ),
    );
  }

}