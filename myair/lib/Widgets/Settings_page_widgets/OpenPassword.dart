
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:myair/main.dart';

class OpenPassword extends StatefulWidget{

  final Function flip; //Reference to the function in PasswordChanger to call the setState on the container and "open" or "close" it

  //Constructor
  const OpenPassword({Key key, this.flip}) : super(key: key);

  @override
  _OpenPasswordState createState() => _OpenPasswordState();

}
class _OpenPasswordState extends State<OpenPassword>{

  //All the controller for the 3 textView of the password
  TextEditingController passOldController = new TextEditingController(); //Old Password TextView Controller
  TextEditingController passNewController = new TextEditingController(); //New Password TextView Controller
  TextEditingController passNewCController = new TextEditingController(); //New Password Again TextView Controller

  var errorNoOldPassword = false;
  var errorNotEquals = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListTile(
            leading: Icon(
              Icons.lock_outline,
            ),
            title: Text("Change Password"),
            trailing: Icon(Icons.keyboard_arrow_down), //Inversion of the arrow
          ),
        ),
        //Form Started

        //Old password insertion
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left:8.0, right: 8.0,bottom: 8.0),
            child: TextField(
              controller: passOldController,
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              //If the password is not the old one show an error otherwise nothing
              decoration: errorNoOldPassword ? new InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                hintText: 'Old Password',
                errorText: 'Password doesn\'t matching',
              ): new InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                hintText: 'Old Password',
              ),
            ),
          ),
        ),

        //Insertion of the new password
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passNewController,
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: errorNotEquals ? new InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                hintText: 'New Password',
                errorText: 'Passwords don\'t matching',
              ): new InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                hintText: 'New Password',
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
              decoration: errorNotEquals ? new InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                hintText: 'New Password Confirmation',
                errorText: ' ',
              ): new InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                hintText: 'New Password Confirmation',
              ),
            ),
          ),
        ),

        //Button for the confirmation of the new password
        Expanded( child:Container(
          child: Center(
            child: FractionallySizedBox(
              heightFactor: 2 / 3,
              widthFactor: 2 / 3,
              child: GestureDetector(
                onTap: () async {
                  if (passOldController.text == actualUser.password) {
                      if (passNewCController.text == passNewController.text) {
                        actualUser.password = passNewCController.text;
                        actualUser.updateUser();
                        widget.flip();
                      } else {
                        setState(() {
                          errorNotEquals = true;
                        });
                      }
                    } else
                      setState(() {
                        errorNoOldPassword = true;
                      });
                  },
                  child: Container(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width/30),
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
                ),
              ),
            ),
          ),
        ),),
      ],
    );
  }
}