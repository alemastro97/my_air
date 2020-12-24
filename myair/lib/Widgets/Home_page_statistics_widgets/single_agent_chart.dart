
import 'dart:math';
import 'package:myair/Constants/pollution_graph_constants.dart';
import 'package:myair/Modules/info_pollution.dart';
import 'package:flutter/cupertino.dart';


class AgentPieChart extends CustomPainter{
  AgentPieChart({@required this.info, @required this.width,@required this.index});
  final List<InfoPollution> info;
  final double width;
  final int index;
  final Limits = [50.0,25.0,200.0,350.0,180.0,180.0];
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 4;

    double total = Limits.elementAt(index);

    double startRadian = pi/2;


      final currentAgent = info.elementAt(index);
      var sweepRadian;

      if(currentAgent.amount > Limits.elementAt(index)){
         sweepRadian = 2 * pi;
         paint.color =  Color.fromRGBO(252,91,57,1);
      }else{
         sweepRadian = currentAgent.amount / total * 2 * pi;
         paint.color =  Color.fromRGBO(123,201,82,1);
      }
      canvas.drawArc(
        Rect.fromCircle(center: center,radius: radius),
        startRadian,
        sweepRadian,
        false,
        paint,
      );
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
