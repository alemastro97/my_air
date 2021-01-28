
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class NameChanger extends StatefulWidget{
  final Function setName;

  const NameChanger({Key key, this.setName}) : super(key: key);
  @override
  _NameChanger createState() => _NameChanger();

}
class _NameChanger extends State<NameChanger>{
  var _modified = false; //boolean which say if the username is in modification or not

TextEditingController nameController = new TextEditingController(); // Textfield controller for the name

//initialization of the settings page
  @override
  initState(){
    super.initState();
    nameController.text = nameController.text = actualUser.firstName + " " + actualUser.lastName;
  }

  @override
  Widget build(BuildContext context) {
    return  //Change name container
      Container(
       // height:MediaQuery.of(context).size.height/13,
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
                          isDense: true,                      // Added this
                          contentPadding: EdgeInsets.all(8),
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
                  !_modified ? GestureDetector(
                    onTap: () { // Check the status of the container by the_modified value
                      onTapFunction();
                    },
                    child: Icon(
                       Icons.edit,
                      color: Colors.white,
                    ),
                  ): Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () { // Check the status of the container by the_modified value
                          onTapFunction();
                        },
                        child: Icon(
                          Icons.save_outlined,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () { // Check the status of the container by the_modified value
                          nameController.text = "";
                          onTapFunction();
                        },
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                ]),
          ),
        ),
      );
  }
  onTapFunction(){
    setState(() {
      _modified = !_modified;
      if(_modified){nameController.text = "";} // If it enter in this if means that the user wants modifies its name
      else{
        if(nameController.text != ""){
          var modifiedNameSurname = nameController.text.split(
              " "); // Get the text in the text view and split that
          actualUser.firstName =
              modifiedNameSurname.elementAt(0);
          actualUser.lastName =
              modifiedNameSurname.elementAt(1);
          actualUser.updateUser();
          widget.setName();
        }
      }
    });
  }
}