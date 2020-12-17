import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/pie_chart.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/Info_list.dart';

class CategoriesRow extends StatelessWidget{
  const CategoriesRow({Key key,}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FractionallySizedBox(
        widthFactor: 1,
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
                      for(var item in kInfo)InfoList(text: item.name,index: kInfo.indexOf(item),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}