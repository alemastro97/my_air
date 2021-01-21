
import 'package:flutter/cupertino.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:myair/Services/Database_service/FirebaseDatabaseHelper.dart';
import 'package:toast/toast.dart';

class SendMailFromLocalHost extends StatefulWidget{
  @override
  _SendMailFromLocalHostState createState() => _SendMailFromLocalHostState();
}

class _SendMailFromLocalHostState extends State<SendMailFromLocalHost>{
  TextEditingController textController = new TextEditingController();
  sendEmail(String comment) async {
      var credentials = (await FirebaseDatabaseHelper().getShadowUserAccount()).split('/');
      String username = credentials.elementAt(0);
      print(username);
      String password = credentials.elementAt(1);
      print(password);
      final smtpServer = gmail(username,password);
    final message = Message()
      ..from = Address(username)
      ..recipients.add('projectmyair@gmail.com')
     ..subject = 'Help&Support Comment in ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Comment:</h1>\n<p>$comment</p>";

    try {
     final sendReport = await send(message, smtpServer);
     showToast("Mail sent",gravity: Toast.CENTER,duration: 3);
     setState(() {
       textController.text = "";
     });
    } on MailerException catch (e) {
      print('Message not sent.' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 9,
            child: TextField(

              controller: textController,
              decoration: InputDecoration(
                hintText: "Enter Your Text...",
                hintStyle: TextStyle(
                  color: Colors.blue,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: (){FocusScope.of(context).unfocus();sendEmail(textController.text);},
              icon: Icon(Icons.email),
            ),
          ),
        ],
      ),
    );
  }

  showToast(String msg,{int duration, int gravity}){
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}