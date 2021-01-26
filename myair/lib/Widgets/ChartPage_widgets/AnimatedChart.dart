import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/AgentPieChart.dart';

class AnimatedChart extends StatefulWidget {

  //List of the colors that changes during the visualization
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  State<StatefulWidget> createState() => AnimatedChartState();
}

class AnimatedChartState extends State<AnimatedChart> {

  int hour = 0;
  int touchedIndex;
  bool isPlaying = false;

  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  //Initial state in which we set the actual hour
  @override
  void initState() {
    hour = DateTime.now().hour;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: const Color(0xff81e5cd),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'Trend of the last 24 hours',
                    style: TextStyle(
                        color: const Color(0xff0f4a3c), fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                 Text(
                    'The height is based on the limits set by ARPA',
                    style: TextStyle(
                        color: const Color(0xff379982), fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        isPlaying ? randomData() : mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: const Color(0xff0f4a3c),
                  ),
                  onPressed: () {
                    setState(() {
                      isPlaying = !isPlaying;
                      if (isPlaying) {
                        refreshState();
                      }
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
      int x,
      double y, {
        bool isTouched = false,
        Color barColor = Colors.white,
        double width = 22,
        List<int> showTooltips = const [],
      }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(6, (i) {
    switch (i) {
      case 0:
        return makeGroupData(0,standardization(DailyUnitData().getPM10Values().value.elementAt(hour),i), isTouched: i == touchedIndex);
      case 1:
        return makeGroupData(1,standardization(DailyUnitData().getPM25Values().value.elementAt(hour),i) , isTouched: i == touchedIndex);
      case 2:
        return makeGroupData(2, standardization(DailyUnitData().getNO2Values().value.elementAt(hour),i), isTouched: i == touchedIndex);
      case 3:
        return makeGroupData(3,standardization(DailyUnitData().getSO2Values().value.elementAt(hour),i), isTouched: i == touchedIndex);
      case 4:
        return makeGroupData(4,standardization(DailyUnitData().getO3Values().value.elementAt(hour),i), isTouched: i == touchedIndex);
      case 5:
        return makeGroupData(5,standardization(DailyUnitData().getCOValues().value.elementAt(hour),i) , isTouched: i == touchedIndex);

      default:
        return null;
    }
  });

  double standardization(double agent, int index){
    if(agent > Limits.elementAt(index)){return 20.0;}
    else{return agent*20.0/Limits.elementAt(index);}
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              double value;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'PM10';
                 value = DailyUnitData().getPM10Values().value.elementAt(hour);
                  break;
                case 1:
                  weekDay = 'PM2.5';
                  value = DailyUnitData().getPM25Values().value.elementAt(hour);
                  break;
                case 2:
                  weekDay = 'NO2';
                  value = DailyUnitData().getNO2Values().value.elementAt(hour);
                  break;
                case 3:
                  weekDay = 'SO2';
                  value = DailyUnitData().getSO2Values().value.elementAt(hour);
                  break;
                case 4:
                  weekDay = 'O3';
                  value = DailyUnitData().getO3Values().value.elementAt(hour);               
                  break;
                case 5:
                  weekDay = 'CO';
                  value = DailyUnitData().getCOValues().value.elementAt(hour);
                  break;
              }
              return BarTooltipItem(
                  weekDay + '\n' + value.toStringAsFixed(2).toString()/*(((rod.y * Limits.elementAt(group.x.toInt()))/20.0).toStringAsFixed(2)).toString()*/, TextStyle(color: Colors.yellow));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) =>
          const TextStyle(color: Color(0xff0f4a3c), fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'PM10';
              case 1:
                return 'PM2.5';
              case 2:
                return 'NO2';
              case 3:
                return 'SO2';
              case 4:
                return 'O3';
              case 5:
                return 'CO';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) =>
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'PM10';
              case 1:
                return 'PM2.5';
              case 2:
                return 'NO2';
              case 3:
                return 'SO2';
              case 4:
                return 'O3';
              case 5:
                return 'CO';

              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(6, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, standardization(DailyUnitData().getPM10Values().value.elementAt(hour),i),
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData(1, standardization (DailyUnitData().getPM25Values().value.elementAt(hour),i),
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData(2,  standardization(DailyUnitData().getNO2Values().value.elementAt(hour),i),
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 3:
            return makeGroupData(3, standardization(DailyUnitData().getSO2Values().value.elementAt(hour),i),
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 4:
            return makeGroupData(4,standardization(DailyUnitData().getO3Values().value.elementAt(hour),i),
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 5:
            return makeGroupData(5, standardization(DailyUnitData().getCOValues().value.elementAt(hour),i),
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);

          default:
            return null;
        }
      }),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      if(hour == 23){hour = 0;}else{hour += 1;}
      refreshState();
    }
  }
}