import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/ActualValue.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/InfoList.dart';


// List of the items related to Actual Air Pollution
class AgentListWidget extends StatelessWidget{
  const AgentListWidget({Key key,}) : super(key:key);

  @override
  Widget build(BuildContext context) {

    return Container(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for(var item in ActualValue().getActualData().value)
            InfoList(text: item.value.name,index: ActualValue().getActualData().value.indexOf(item),), // items description and color
        ],
      ),
    );

  }

}
