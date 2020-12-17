
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/pie_chart.dart';
import 'Agent_information_box.dart';
import 'package:myair/Views/Home_page_views/pie_chart_view.dart';

import 'CategoriesRow.dart';
import 'GridAgents.dart';

class GraphWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light ? Color.fromRGBO(193, 214, 233, 1) :  Color(0xFF212121),
      body: Stack(
        children: [
          SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    PieChartView(),
                    Expanded(
                      flex: 2,
                        child: GridAgentWidget(),
                      ),
                  ],
                ),
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: 0.1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light ? Color.fromRGBO(193, 214, 233, 1) : Color(0xFF212121),
                    shape: BoxShape.circle,
                    boxShadow:[
                      BoxShadow(
                      spreadRadius: -2,
                      blurRadius: 0,
                      offset: Offset(0,-4),
                      color: Theme.of(context).brightness == Brightness.light ?Colors.grey : Colors.black,
                    ),],
                  ),

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
