
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:myair/Constants/pollution_graph_constants.dart';
import 'package:myair/Modules/info_pollution.dart';

//Main pie chart creation
class PieChart extends CustomPainter {

  PieChart({@required this.info, @required this.width});

  final List<ValueNotifier<InfoPollution>> info;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {

    Offset center = Offset(size.width / 2, size.height / 2); // Definition of the center of the chart
    double radius = min(size.width / 2, size.height / 2); //Definition of the radius

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;

    double total = 0;
    info.forEach((expense) => total += expense.value.amount);

    double startRadian = -pi / 2;

    //Loop on all the actual value
    for (var index = 0; index < info.length; index++) {
      final currentAgent = info.elementAt(index);
      final sweepRadian = currentAgent.value.amount / total * 2 * pi;
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
