import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myair/Widgets/Help&Support_page_widgets/SendMailFromLocalHost.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).brightness == Brightness.light ? Color.fromRGBO(193, 214, 233, 1) :  Color(0xFF212121),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Help & Support"),
        actions:[Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(LineAwesomeIcons.question_circle),
        ),],
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(

                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/help_support_background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                //height: MediaQuery.of(context).size.height/2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(

                    children:<Widget> [
                      Expanded(
                        flex: 6,
                        child: Column(children:<Widget>[Text(
                          "Send us an anonymous email to help us improve the experience within myair or to report any problems",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // color: LightColors.kDarkBlue,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                              ),
                        ),

                        SendMailFromLocalHost(),],
),
                      ),

                     Expanded(
                       flex: 2,
                       child: Container(
                         alignment: Alignment.bottomCenter,
                         child: RichText(
                           textAlign: TextAlign.center,
                              text: new TextSpan(
                              style: new TextStyle(

                                 //fontSize: 14.0,
                                 color: Theme.of(context).brightness == Brightness.light ?  Color(0xff0f4a3c) : Colors.white,
                               ),
                                children: <TextSpan>[
                                  new TextSpan(text: 'Do you want to know more about myair and the data collected by the '),
                                  new TextSpan(text: 'ARPA', style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.blue), recognizer:  new TapGestureRecognizer()..onTap = () => _launchURL('https://www.arpalombardia.it/Pages/Contatti_URP.aspx')),
                                  new TextSpan(text: ' sensors?'),
                                ],
                              ),
                            ),
                       ),
                     ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.facebookSquare),
                                onPressed: () => _launchURL("https://it-it.facebook.com/login/"),
                              ),
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.instagramSquare),
                                onPressed: () => _launchURL("https://www.instagram.com/?hl=it"),

                              ),
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.twitterSquare),
                                onPressed: () => _launchURL("https://twitter.com/login?lang=it"),

                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          )
      ),

    );
  }
  _launchURL(String url) async {
   
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
