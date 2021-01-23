import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myair/Services/Database_service/DatabaseHelper.dart';
import 'package:myair/Services/Database_service/FirebaseDatabaseHelper.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/AgentPieChart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Widgets/Settings_page_widgets/SliderAgent.dart';
import '../../main.dart';

class SettingsPageWidget extends StatefulWidget{
  final setname;

  const SettingsPageWidget({Key key, this.setname}) : super(key: key);
  @override
  _SettingsPageWidgetState createState() => _SettingsPageWidgetState();
}

class _SettingsPageWidgetState extends State<SettingsPageWidget>{
  var _modified = false;
  var _flipped = false;
  var _height = 0.0;
  var _myAnimatedWidget;
  TextEditingController nameController = new TextEditingController();
  @override
  initState(){
    super.initState();
    nameController.text = nameController.text = actualUser.firstName + " " + actualUser.lastName;

  }
  @override
  Widget build(BuildContext context) {
    _height == 0 ? _height =  MediaQuery.of(context).size.height/12: null;
    _myAnimatedWidget == null ? _myAnimatedWidget = ClosePassword(): null;
  return Scaffold(
    backgroundColor: Theme.of(context).brightness == Brightness.light ? Color.fromRGBO(193, 214, 233, 1) :  Color(0xFF212121),
    appBar: AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text("Settings"),
      actions:[Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(LineAwesomeIcons.cog),
      ),],
      centerTitle: true,
    ),
    body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height:MediaQuery.of(context).size.height/13,
                width: MediaQuery.of(context).size.width,
                child: Card(

                  elevation: 8.0,
                  shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(10.0)),
                  color: Theme.of(context).brightness == Brightness.light ? Color(0xFF6488E4) : Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children :<Widget> [
                    Flexible(
                      child: Container(  child:!_modified ?
                        Text(
                          actualUser.firstName + " " + actualUser.lastName,
                          style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          selectionHeightStyle:
                                              BoxHeightStyle.tight,
                                          controller: nameController,
                                          keyboardType: TextInputType.text,
                                          decoration: new InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            hintText: "Insert new name",
                                            // labelText: 'Email',
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _modified = !_modified;
                                  var listnamesur =
                                      nameController.text.split(" ");
                                  actualUser.firstName =
                                      listnamesur.elementAt(0);
                                  actualUser.lastName =
                                      listnamesur.elementAt(1);
                                  DatabaseHelper().deleteUser();
                                  DatabaseHelper().insertUser(actualUser);
                                  FirebaseDatabaseHelper().updateUser();
                                  widget.setname();
                                });
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),


                AnimatedContainer(
                  height: _height,
                  width: MediaQuery.of(context).size.width,
                  duration: Duration(milliseconds: 200),
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 100),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width /
                            30), //color:  Theme.of(context).cardTheme.color,
                  ),
                  child: Center(
                    child: GestureDetector(

                      child: Card(
                        elevation: 4,
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 700),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) =>
                                  ScaleTransition(
                                   child: child,
                                   scale: animation,
                                   ),
                          child:Center(child:
                          _myAnimatedWidget),
                        ),
                      ),onTap: (){
                        print("sssssssss");
                      flip();
                    },
                    ),
                  ),
                ),


              const SizedBox(height: 20.0),
              Text(
                "Notification Settings",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.light ? Colors.indigo : Theme.of(context).accentColor,
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SwitchListTile(
                    activeColor: Theme.of(context).brightness == Brightness.light ? Color(0xFF6488E4) : Theme.of(context).accentColor,
                    contentPadding: const EdgeInsets.all(0),
                    value: actualUser.notificationSend,
                    title: Text("Received notification"),
                    onChanged: (val) {
                      setState(() {
                        actualUser.notificationSend = val;
                        DatabaseHelper().deleteUser();
                        DatabaseHelper().insertUser(actualUser);
                        FirebaseDatabaseHelper().updateUser();
                      });
                    },
                  ),
                  Text(
                    "Push notification that you received in case you are entering a polluted area",
                    style: TextStyle(
                      //fontSize: 12.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  for(var index = 0; index < actualUser.notificationLimits.length ; index++ )
                    SliderAgent(max: Limits.elementAt(index),index: index,change: actualUser.notificationSend,),
                ],
              ),


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SwitchListTile(
                    activeColor:Theme.of(context).brightness == Brightness.light ? Color(0xFF6488E4) : Theme.of(context).accentColor,
                    contentPadding: const EdgeInsets.all(0),
                    value: actualUser.notificationReward ,
                    title: Text("Received reward's notification "),
                    onChanged: (val) {
                      setState(() {
                        actualUser.notificationReward = val;
                        DatabaseHelper().deleteUser();
                        DatabaseHelper().insertUser(actualUser);
                        FirebaseDatabaseHelper().updateUser();
                      });
                    },
                  ),
                  Text(
                    "Push notification received if you complete a challenge",
                    style: TextStyle(
                      //fontSize: 12.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),



              const SizedBox(height: 60.0),
            ],
          ),
        ),
        Positioned(
          bottom: -20,
          left: -20,
          child: Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 00,
          left: 00,
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.powerOff,
              color: Colors.white,
            ),
            onPressed: () async {
              await DatabaseHelper().insertDailyData();
              print("Close app");
            },
          ),
        )
      ],
    ),

  );
}
  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }

  void flip() {
    _flipped = !_flipped;
    setState(() {
      _height == MediaQuery.of(context).size.height/12
          ? _height = MediaQuery.of(context).size.width
          : _height = MediaQuery.of(context).size.height/12;
      !_flipped
          ? _myAnimatedWidget = ClosePassword()
          : _myAnimatedWidget = OpenPassword(flip:flip);
    });
  }

}
class OpenPassword extends StatefulWidget{
  final Function flip;

  const OpenPassword({Key key, this.flip}) : super(key: key);
  _OpenPasswordState createState() => _OpenPasswordState();
}
class _OpenPasswordState extends State<OpenPassword>{
  TextEditingController passOldController = new TextEditingController();
  TextEditingController passNewController = new TextEditingController();
  TextEditingController passNewCController = new TextEditingController();
  var error = false;
  var error_2 = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListTile(
            leading: Icon(
              Icons.lock_outline,
              //color: Colors.purple,
            ),
            title: Text("Change Password"),
            trailing: Icon(Icons.keyboard_arrow_down),

          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left:8.0, right: 8.0,bottom: 8.0),
            child: TextField(
              controller: passOldController,
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: error ? new InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                hintText: 'Old Password',
                errorText: 'Password doesn\'t matching',
                //labelText: 'Email',

              ): new InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                hintText: 'Old Password',
                // labelText: 'Email',

              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passNewController,
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: error_2 ? new InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                hintText: 'New Password',
                errorText: 'Passwords don\'t matching',
                //labelText: 'Email',

              ): new InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                hintText: 'New Password',
                // labelText: 'Email',

              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passNewCController,
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: error_2 ? new InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                hintText: 'New Password Confirmation',
                errorText: ' ',
                //labelText: 'Email',

              ): new InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                hintText: 'New Password Confirmation',
                // labelText: 'Email',

              ),
            ),
          ),
        ),
        Expanded( child:Container(
          child: Center(
            child: FractionallySizedBox(
              heightFactor: 2 / 3,
              widthFactor: 2 / 3,
              child: GestureDetector(
                onTap: () async {
                  if(passOldController.text == actualUser.password)
                    {if(passNewCController.text == passNewController.text){
                          actualUser.password = passNewCController.text;
                          DatabaseHelper().deleteUser();
                          DatabaseHelper().insertUser(actualUser);
                          FirebaseDatabaseHelper().updateUser();
                          widget.flip();
                    }else{
                      setState(() {
                      error_2 = true;
                    });}}
                  else
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
                    color: Theme.of(context).brightness == Brightness.light ? Color(0xFF6488E4) : Theme.of(context).accentColor,
                  ),

                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        'Change Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.light? Colors.white : Theme.of(context).textTheme
                        ),
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
    );
  }
}

class ClosePassword extends StatelessWidget{
  final Function flip;

  const ClosePassword({Key key, this.flip}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width/100),
      child: Container(

        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:<Widget>[
              Icon(
                Icons.lock_outline,
                // color: Colors.purple,
              ),
              Flexible(child: FractionallySizedBox(heightFactor:0.5,child: FittedBox(fit:BoxFit.contain,child: Text("Change Password")))), Icon(Icons.keyboard_arrow_right),]

        ),
      ),
    );
  }
}
