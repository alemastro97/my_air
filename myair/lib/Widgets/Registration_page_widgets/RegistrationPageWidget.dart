
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Widgets/Opening_page_widgets/LogoWidget.dart';
import 'package:myair/Widgets/Registration_page_widgets/RegistrationForm.dart';

class RegistrationPageWidget extends StatefulWidget{
  _RegistrationPageWidgetState createState() =>  _RegistrationPageWidgetState();

}
class _RegistrationPageWidgetState extends State<RegistrationPageWidget>{


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
                    child: RegistrationForm(),
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