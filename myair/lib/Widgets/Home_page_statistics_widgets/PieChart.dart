import 'dart:ffi';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:myair/Constants/pollution_graph_constants.dart';
import 'package:myair/Modules/info_pollution.dart';
import 'package:flutter/cupertino.dart';

//var PM10 = ValueNotifier<double>(23.0);

/*List<ValueNotifier<InfoPollution>> kInfo = new List(
  ValueNotifier<InfoPollution>(InfoPollution('PM10', amount: 23.0)),
  ValueNotifier<InfoPollution>(InfoPollution('PM2.5', amount: 23.0)),
  ValueNotifier<InfoPollution>(InfoPollution('NO2', amount: 37.0)),
  ValueNotifier<InfoPollution>(InfoPollution('SO2', amount: 15.0)),
  ValueNotifier<InfoPollution>(InfoPollution('O3', amount: 17.0)),
  ValueNotifier<InfoPollution>(InfoPollution('O3', amount: 12.0)),);
*/

/*
class ValueListenableBuilder2<A, B> extends StatelessWidget {
  ValueListenableBuilder2(
    this.pm10,
    this.pm25,
      this.no2,
      this.so2,
      this.o3,
      this.pm25,
      {
    Key key,
    this.builder,
    this.child,
  }) : super(key: key);

  ValueListenable<A> first;
  ValueListenable<B> second;
  Widget child;
  Widget Function(BuildContext context, A a, B b, Widget child) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (_, a, __) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (context, b, __) {
            return builder(context, a, b, child);
          },
        );
      },
    );
  }
}
*/
class PieChart extends CustomPainter {
  PieChart({@required this.info, @required this.width});

  final List<ValueNotifier<InfoPollution>> info;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;

    double total = 0;
    info.forEach((expense) => total += expense.value.amount);

    double startRadian = -pi / 2;

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
