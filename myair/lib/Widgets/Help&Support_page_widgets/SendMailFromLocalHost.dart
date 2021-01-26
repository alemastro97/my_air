
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
  //Text controller to take the message from the textView
  TextEditingController textController = new TextEditingController();

  //Function that sends the message
  sendEmail(String comment) async {
    //Get the credential for the shadow user from the firebase database -> it guarantees anonymity
      var credentials = (await FirebaseDatabaseHelper().getShadowUserAccount()).split('/');
      String username = credentials.elementAt(0);
      String password = credentials.elementAt(1);

      // ignore: deprecated_member_use
      final smtpServer = gmail(username,password); //Login with credentials
      final message = Message() //Generation of the email
      ..from = Address(username)    //Shadow user is the sender
      ..recipients.add('projectmyair@gmail.com') //Our email account is the recipient
     ..subject = 'Help&Support Comment in ${DateTime.now()}' //Subject of the emial
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Comment:</h1>\n<p>$comment</p>"; //Comment of the user

    try {
     await send(message, smtpServer);
     showToast("Mail sent",gravity: Toast.CENTER,duration: 3); //Show the toast to notify that the email is sent successfully
     setState(() {
       textController.text = ""; //Delete the comment when the email is sent
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
              onPressed: (){
                FocusScope.of(context).unfocus();
                sendEmail(textController.text);
                },
              icon: Icon(Icons.email),
            ),
          ),
        ],
      ),
    );
  }

  //When the email is sent it shows a toast with the message of task accomplished or not
  showToast(String msg,{int duration, int gravity}){
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}