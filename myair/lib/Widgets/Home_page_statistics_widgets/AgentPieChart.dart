
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:myair/Constants/pollution_graph_constants.dart';
import 'package:myair/Modules/info_pollution.dart';



// Manage the shadow according the value and the limit related to each agent
class AgentPieChart extends CustomPainter{

  final List<ValueNotifier<InfoPollution>> info;
  final double width;
  final int index;

  AgentPieChart({@required this.info, @required this.width,@required this.index});

  //Pie chart for the agent [index]
  @override
  void paint(Canvas canvas, Size size) {

    //Definition of the center as a point of(size.width / 2, size.height / 2)
    Offset center = Offset(size.width / 2, size.height / 2);
    //Definition of the radius
    double radius = min(size.width / 2, size.height / 2);

    //Definition of the painting style (circle) and the stroke of the circle
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 4;

    //Definition of the perimeter as the max value for which the aqi become hazardous for that agent
    //Limits defined by the ARPA Lombardia
    double total = Limits.elementAt(index);

    //Define the start of the circle
    double startRadian = pi/2;

    //Actual value of the agent
    final currentAgent = info.elementAt(index);
    //Total amount of circle already covered
    var sweepRadian;

    // Shadow related to the value of the agent
    // It becomes red in case of the value exceeds the related limit
    if(currentAgent.value.amount > Limits.elementAt(index)){
      sweepRadian = 2 * pi;
      paint.color =  Color.fromRGBO(252,91,57,1);
    } else {
      sweepRadian = currentAgent.value.amount / total * 2 * pi;
      paint.color =  Color.fromRGBO(123,201,82,1);
    }

    //Draw the line related to the value of the agent
    canvas.drawArc(
      Rect.fromCircle(center: center,radius: radius),
      startRadian,
      sweepRadian,
      false,
      paint,
    );

    // Shadow closed to the circle
    startRadian += sweepRadian;
    paint.color = Color.fromRGBO(192,192,192, 1);
    paint.strokeWidth =  width /8;
    canvas.drawArc(
      Rect.fromCircle(center: center,radius: radius),
      startRadian,
      2*pi - sweepRadian,
      false,
      paint,
    );

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

