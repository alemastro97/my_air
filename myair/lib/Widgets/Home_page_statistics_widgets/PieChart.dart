

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Constants/pollution_graph_constants.dart';
import 'package:myair/Modules/InfoPollution.dart';

//Main pie chart creation
class PieChart extends CustomPainter {
  final bool light;


  PieChart({@required this.info, @required this.width, this.light});

  final List<ValueNotifier<InfoPollution>> info;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    var  sweepRadian = 0.0;
    Offset center = Offset(size.width / 2, size.height / 2); // Definition of the center of the chart
    double radius = min(size.width / 2, size.height / 2); //Definition of the radius

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;

    double total = 0;
    Limits.forEach((expense) => total += expense);

    double startRadian = -pi / 2;

    //Closing the circle
    //startRadian += sweepRadian;
    paint.color = Color.fromRGBO(192,192,192, 1);
    paint.strokeWidth =  width /4;
    canvas.drawArc(
      Rect.fromCircle(center: center,radius: radius),
      startRadian,
      2*pi - startRadian,
      false,
      paint,
    );
    paint.color = light ? Colors.white : Color(0xFF373737);
    paint.strokeWidth =  width /6;
    canvas.drawArc(
      Rect.fromCircle(center: center,radius: radius),
      startRadian,
      2*pi - startRadian,
      false,
      paint,
    );
    paint.strokeWidth =  width /2;
    //Loop on all the actual value
    for (var index = 0; index < info.length; index++) {
      final currentAgent = info.elementAt(index);
      sweepRadian = currentAgent.value.amount / total * 2 * pi;
      paint.color = kNeumorphicColors.elementAt(index % info.length);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startRadian,
        sweepRadian,
        false,
        paint,
      );
      startRadian += sweepRadian;
    }



  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
