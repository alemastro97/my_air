
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:myair/Widgets/Settings_page_widgets/ClosePassword.dart';

import 'package:myair/Widgets/Settings_page_widgets/OpenPassword.dart';

class PasswordChanger extends StatefulWidget{
  @override
  _PasswordChangerState createState() => _PasswordChangerState();
}
class _PasswordChangerState extends State<PasswordChanger>{
  var _flipped = false; //Used to open/close the password modification
  var _height = 0.0; //Dimesion of the password container
  var _myAnimatedWidget; //Password container

  @override
  Widget build(BuildContext context) {
    //Check the actual dimension of the password container
    _height == 0 ? _height =  MediaQuery.of(context).size.height/12: null;
    //Set the initial widget for the password
    _myAnimatedWidget == null ? _myAnimatedWidget = ClosePassword(): null;
    return //Change password container
      AnimatedContainer(
        height: _height,
        width: MediaQuery.of(context).size.width,
        duration: Duration(milliseconds: 200),
        padding:
        EdgeInsets.all(MediaQuery.of(context).size.width / 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.width /
                  30),
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
            flip();
          },
          ),
        ),
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