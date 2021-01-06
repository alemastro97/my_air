import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/PieChart.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/InfoList.dart';

class AgentListWidget extends StatelessWidget{
  const AgentListWidget({Key key,}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for(var item in kInfo)
            InfoList(text: item.name,index: kInfo.indexOf(item),),
        ],
      ),
    );
  }

}
/*Flexible(
      child: Container(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ///Pollution Fields
            Expanded(
              flex: 9,
              child: Container(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for(var column = 0; column < kInfo.length/2; column ++)
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: <Widget>[
                            for(var row = 0; row < 2; row ++)
                              Expanded(
                                flex:1,
                                child:InfoList(text: kInfo.elementAt(column*2 + row).name,index: column*2 + row,),
                              ),
                          ],
                        ),
                      ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )*/