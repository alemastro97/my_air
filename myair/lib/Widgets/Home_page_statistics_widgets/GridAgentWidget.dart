
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:myair/main.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/AgentInfoWidget.dart';

class GridAgentWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for(var column = 0; column < kInfo.value.length/2; column ++)
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                for(var row = 0; row < 2; row ++)
                  Flexible(
                    child: AgentInfoWidget(index: (column*2 + row),),
                  ),
              ],
            ),
          ),
      ],
    );
  }

}
