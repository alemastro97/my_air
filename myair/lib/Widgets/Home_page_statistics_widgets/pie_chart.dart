
import 'dart:math';
import 'package:myair/Constants/pollution_graph_constants.dart';
import 'package:myair/Modules/info_pollution.dart';
import 'package:flutter/cupertino.dart';

var kInfo = [
  InfoPollution('PM10', amount: 23.0),
  InfoPollution('PM2.5', amount: 23.0),
  InfoPollution('NO2', amount: 37.0),
  InfoPollution('SO2', amount: 15.0),
  InfoPollution('O3', amount: 17.0),
  InfoPollution('O3', amount: 12.0),
];

class PieChart extends CustomPainter{
  PieChart({@required this.info, @required this.width});
  final List<InfoPollution> info;
  final double width;
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;

    double total = 0;
    info.forEach((expense) => total += expense.amount);

    double startRadian = -pi/2;

    for(var index = 0; index < info.length; index++){
      final currentAgent = info.elementAt(index);
      final sweepRadian = currentAgent.amount / total * 2 * pi;
      paint.color = kNeumorphicColors.elementAt(index % info.length);
      canvas.drawArc(
          Rect.fromCircle(center: center,radius: radius),
          startRadian,
          sweepRadian,
          false,
          paint,
      );
      startRadian+=sweepRadian;
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

