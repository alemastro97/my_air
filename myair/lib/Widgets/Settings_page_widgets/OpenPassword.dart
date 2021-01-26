
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:myair/main.dart';

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
                    actualUser.updateUser();
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
                ),
              ),
            ),
          ),
        ),),
      ],
    );
  }
}