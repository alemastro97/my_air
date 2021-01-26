import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myair/Constants/pollution_graph_constants.dart';
import 'package:myair/Modules/info_pollution.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/AgentPieChart.dart';

import 'package:myair/main.dart';

class AgentInfoWidget extends StatelessWidget {
  final int index;

  //Constructor
  AgentInfoWidget({this.index});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width / 70),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(MediaQuery.of(context).size.width / 20),
        ),

        //Keep track about the changes of kInfo in order to update the value and the PieChart of the agent
        child: ValueListenableBuilder(
          builder: (BuildContext context, InfoPollution value, Widget child) {

            return Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      //Title of the subCard with the colored circle
                      Flexible(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kNeumorphicColors
                                .elementAt(index % kNeumorphicColors.length),
                          ),
                        ),
                      ),

                      //Title of the subCard with the agent name
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width / 100),
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text(
                                value.name,
                              ),
                            ),
                          )),

                    ],
                  ),
                ),

                //Pie of the agent with the internal value
                Flexible(
                  flex: 3,
                  child: Center(
                    child: Container(
                      child: LayoutBuilder(
                        builder: (context, constraint) => FractionallySizedBox(
                          widthFactor: 0.7,
                          heightFactor: 0.7,
                          child: Container(
                            child: Stack(
                              children: [
                                //Pie chart
                                Center(
                                  child: SizedBox(
                                    width: constraint.maxWidth * 0.6,
                                    child: CustomPaint(
                                      child: Center(),
                                      foregroundPainter: AgentPieChart(
                                        info: kInfo.value,
                                        width: constraint.maxWidth * 0.4,
                                        index: index,
                                      ),
                                    ),
                                  ),
                                ),

                                //Shadows to made a 3D effect and value of the pie
                                Center(
                                  child: Container(
                                    height: constraint.maxWidth * 0.4,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                          Brightness.light
                                          ? Color.fromRGBO(255, 255, 255, 1)
                                          : Color(0xFF373737),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 2,
                                          offset: Offset(-1, -1),
                                          color: Theme.of(context).brightness ==
                                              Brightness.light
                                              ? Colors.white
                                              : Colors.grey.shade200,
                                        ),
                                        BoxShadow(
                                          spreadRadius: -2,
                                          blurRadius: 10,
                                          offset: Offset(5, 5),
                                          color: Theme.of(context).brightness ==
                                              Brightness.light
                                              ? Colors.black.withOpacity(1)
                                              : Colors.white.withOpacity(1),
                                        ),
                                      ],
                                    ),

                                    //Value of the agent
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: FractionallySizedBox(
                                            widthFactor: 0.3,
                                            heightFactor: 0.3,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                value.amount
                                                    .toStringAsFixed(2)
                                                    .toString(),
                                                style: GoogleFonts.rubik(
                                                  fontWeight: FontWeight.w400,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.grey,
                                                      offset: Offset(1, 1),
                                                      blurRadius: 2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          valueListenable: kInfo.value.elementAt(index), //Listened value, every time it change it rewrite the widget
        ),
      ),
    );
  }
}
