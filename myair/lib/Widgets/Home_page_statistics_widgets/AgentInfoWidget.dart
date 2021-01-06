

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myair/Constants/pollution_graph_constants.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/PieChart.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/AgentPieChart.dart';

class AgentInfoWidget extends StatelessWidget{
  final int index;
  AgentInfoWidget({this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom:MediaQuery.of(context).size.width/70),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/20),
        ),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child:Container(
                      width: MediaQuery.of(context).size.width/30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kNeumorphicColors.elementAt( index % kNeumorphicColors.length),
                      ),
                    ),
                  ),
                  Expanded(
                      child:
                      Container(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width/100),
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            kInfo.elementAt(index).name ,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child:  Center(
                child: Container(
                  child: LayoutBuilder(
                    builder: (context, constraint) => FractionallySizedBox(
                      widthFactor: 0.7,heightFactor: 0.7,
                      child: Container(
                        child: Stack(
                          children: [
                            Center(
                              child: SizedBox(
                                width: constraint.maxWidth*0.6,
                                child: CustomPaint(
                                  child: Center(),
                                  foregroundPainter: AgentPieChart(
                                    width: constraint.maxWidth*0.4,
                                    info: kInfo,
                                    index: index,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                height: constraint.maxWidth * 0.4,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness == Brightness.light ? Color.fromRGBO(255, 255, 255, 1) : Color(0xFF373737) ,//Color.fromRGBO(193, 214, 233, 1),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      offset: Offset(-1,-1),
                                      color: Theme.of(context).brightness == Brightness.light ?  Colors.white : Colors.grey.shade200,
                                    ),
                                    BoxShadow(
                                      spreadRadius: -2,
                                      blurRadius: 10,
                                      offset: Offset(5,5),
                                      color: Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(1) : Colors.white.withOpacity(1),
                                    ),

                                  ],
                                ),
                                child: Center(
                                  child: FractionallySizedBox(
                                    widthFactor: 0.3, heightFactor: 0.3,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        kInfo.elementAt(index).amount.toString(),
                                        style: GoogleFonts.rubik(
                                          fontWeight: FontWeight.w400,
                                          shadows: [
                                            Shadow(
                                              color: Colors.grey,
                                              offset: Offset(1,1),
                                              blurRadius: 2,
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
                        ),
                      ),
                    ),
                  ),
                ),
              ),),
          ],
        ),
      ),
    );
  }

}