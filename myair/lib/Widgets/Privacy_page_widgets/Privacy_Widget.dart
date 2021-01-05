import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PrivacyWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Theme.of(context).brightness == Brightness.light ? Color.fromRGBO(193, 214, 233, 1) :  Color(0xFF212121),
     appBar: AppBar(
       automaticallyImplyLeading: false,
       leading: IconButton(
         icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color),
         onPressed: () => Navigator.of(context).pop(),
       ),
       title: Text("Privacy"),
       actions:[Padding(
         padding: const EdgeInsets.all(8.0),
         child: Icon(LineAwesomeIcons.user_shield),
       ),],
       centerTitle: true,
     ),
     body: Container(),
   );
  }

}