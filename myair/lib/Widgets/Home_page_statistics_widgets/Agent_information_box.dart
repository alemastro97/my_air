

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myair/Constants/pollution_graph_constants.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/pie_chart.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/single_agent_chart.dart';

class AgentInfoWidget extends StatelessWidget{
  final int index;
  AgentInfoWidget({this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                                  width: constraint.maxWidth*0.5,
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
                                  widthFactor: 0.4, heightFactor: 0.4,
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
    );
  }

}
/*Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(

          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,

                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: FractionallySizedBox(
                            widthFactor: 0.6, heightFactor: 0.6,
                            child: Container(
                              // this Container’s child will be a ClipOval,
                              // which in turn contains an Image as a child.
                              // A ClipOval is used so it can crop
                              // the image into a circle
                              decoration: BoxDecoration(shape: BoxShape.circle,color:  kNeumorphicColors.elementAt(index),),
                            ),
                          ),
                        ),

                    ) ,
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: FractionallySizedBox(
                            heightFactor: 2/3,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                kInfo.elementAt(index).name,
                                style: TextStyle(
                                  color: Colors.grey,
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
              Expanded(
                flex: 2,
                child: FractionallySizedBox(
                  widthFactor: 1,heightFactor: 1,
                  child: Container(
                    child: LayoutBuilder(
                      builder: (context, constraint) => FractionallySizedBox(
                        widthFactor: 0.5,heightFactor: 0.5,
                        child: Container(
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  width: constraint.maxWidth*0.6,
                                  child: CustomPaint(
                                    child: Center(),
                                    foregroundPainter: AgentPieChart(
                                      width: constraint.maxWidth*0.5,
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
                                        color:Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(1) : Colors.white.withOpacity(1),
                                      ),

                                    ],
                                  ),
                                  child: Center(
                                    child: FractionallySizedBox(
                                      widthFactor: 0.4, heightFactor: 0.4,
                                        child: FittedBox(
                                            fit: BoxFit.fitHeight,
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
                ),

              ),
            ],
          ),

        ),
      ),
    )*/