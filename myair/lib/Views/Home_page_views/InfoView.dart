
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class InfoView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light ? Color.fromRGBO(193, 214, 233, 1) :  Color(0xFF212121),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("AQI Guide"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width/30),
        child: ListView(
          children:<Widget>[
            Container(
              child: AutoSizeText(
                "AQI, or Air Quality Index, is a system for reporting the severity of air quality levels in relatable terms to the public. The index ranges from 0 to 500, where high index values indicate higher levels of air pollution and higher potential for adverse healt effects. Any value larger than 300, for example, is considered to be hazardous, while an AQI value of 0-50, on the other hand, represents good air quality",
              ),
            ),

            Card(elevation: 1.0,

                child:Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(

                          color: Colors.red,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width/50),
                            child:Text(
                              "0 - 50 Good",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.width/50),
                            child:Text(
                              "Air quality is satisfactory and poses liitle or no risk. Ventilating your home is recommended",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),

            Card(elevation: 1.0,
                child:Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(

                          color: Colors.red,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width/50),
                            child:Text(
                              "51 - 100 Moderate",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.width/50),
                            child:Text(
                              "Sensitive individuals should avoid outdoor activiy as they may experience respiratory symptoms",

                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),

            Card(elevation: 1.0,
                child:Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(

                          color: Colors.red,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width/50),
                            child:Text(
                              "101 - 150 Unhealty for sensitive groups",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.width/50),
                            child:Text(
                              "General public and sensitive individuals in particular are at risk to experience irritation and respiratory problems",

                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),

            Card(elevation: 1.0,
                child:Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(

                          color: Colors.red,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width/50),
                            child:Text(
                              "151 - 200 Unhealthy",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.width/50),
                            child:Text(
                              "Increased lielihood of adverse effects and aggravation to the heart and lungs among general public - particularly for sensitive groups",

                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),

            Card(
                elevation: 1.0,
                child:Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(

                          color: Colors.red,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width/50),
                            child:Text(
                              "201 - 300 Very Unhealthy",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.width/50),
                            child:Text(
                              "General public will be noticeably affected. Sensitive groups will experience reduced endurance in activities. These individuals should remain indoors and restrict activities.",

                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),
            Card(elevation: 1.0,
            child:Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(

                      color: Colors.red,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.width/50),
                          child:Text(
                            "301 - 500 Hazardous",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                      ),
                      Container(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width/50),
                          child:Text(
                            "General public and sensitive groups are at high risk to experience strong irritations and adverse health affects that could trigger other illnesses. Everyone should avoid exercise and remain indoors",
                       //     maxLines:5,
                          ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
          ],
        ),/* ListView(
          children: [
            ///Incipit
           Container(
             child: AutoSizeText(
                  "AQI, or Air Quality Index, is a system for reporting the severity of air quality levels in relatable terms to the public. The index ranges from 0 to 500, where high index values indicate higher levels of air pollution and higher potential for adverse healt effects. Any value larger than 300, for example, is considered to be hazardous, while an AQI value of 0-50, on the other hand, represents good air quality",
                ),
           ),

            ///0-50
            Card(
              elevation: 1.0,
              child: Column(
                children: [
                  AutoSizeText(
                    "0 - 50 Good",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  AutoSizeText(
                    "Air quality is satisfactory and poses liitle or no risk. Ventilating your home is recommended",
                  ),
                ],
              ),
            ),
            ///51-100
            Card(
              elevation: 1.0,
              child: Column(
                children: [
                  AutoSizeText(
                    "51 - 100 Moderate",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  AutoSizeText(
                    "Sensitive individuals should avoid outdoor activiy as they may experience respiratory symptoms",
                  ),
                ],
              ),
            ),
            ///101-150
            Card(
            elevation: 1.0,
            child: Column(
              children: [
                AutoSizeText(
                  "101 - 150 Unhealty for sensitive groups",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                AutoSizeText(
                  "General public and sensitive individuals in particular are at risk to experience irritation and respiratory problems",
                ),
              ],
            ),
            ),
            ///151-200
            Card(
            elevation: 1.0,
            child: Column(
              children: [
                AutoSizeText(
                  "151 - 200 Unhealthy",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                AutoSizeText(
                  "Increased lielihood of adverse effects and aggravation to the heart and lungs among general public - particularly for sensitive groups",
                ),
              ],
            ),
            ),
            ///201-300
            Card(
            elevation: 1.0,
            child: Column(
              children: [
                AutoSizeText(
                  "201 - 300 Very Unhealthy",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                AutoSizeText(
                  "General public will be noticeably affected. Sensitive groups will experience reduced endurance in activities. These individuals should remain indoors and restrict activities.",
                ),
              ],
            ),
            ),
            ///301-500
            Card(
            elevation: 1.0,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(


                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    child: Column(
                      children: [
                         Text(
                            "301 - 500 Hazardous",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                        Expanded(
                          child: Text(
                            "General public and sensitive groups are at high risk to experience strong irritations and adverse health affects that could trigger other illnesses. Everyone should avoid exercise and remain indoors",
                            maxLines:5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),),
          ],
        ),*/
      ),
    );
  }
}