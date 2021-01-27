import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Password tile when the user don't select it
class ClosePassword extends StatelessWidget {
  final Function flip; //reference to the function flip in PasswordChanger

  //Constructor
  const ClosePassword({Key key, this.flip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 100),
      child: Container(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                Icons.lock_outline,
              ),
              Flexible(
                  child: FractionallySizedBox(
                      heightFactor: 0.5,
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text("Change Password")))),
              Icon(Icons.keyboard_arrow_right),
            ]),
      ),
    );
  }
}
