
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/pie_chart.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/single_agent_chart.dart';

import 'Agent_information_box.dart';

class GridAgentWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Theme.of(context).brightness == Brightness.light ? Colors.white60 : Colors.grey,
            elevation: 1.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              children: <Widget>[
                for(var column = 0; column < kInfo.length/2; column ++)
                Expanded(
                  flex: 1,
                  child: Row(
                   children: <Widget>[
                     for(var row = 0; row < 2; row ++)
                     Expanded(
                         flex:1,
                         child: AgentInfoWidget(index: (column*2 + row),),
                     ),
                   ],
                  ),
                ),


              ],
            ),
          ),
        ),
      ],
    );
  }

}