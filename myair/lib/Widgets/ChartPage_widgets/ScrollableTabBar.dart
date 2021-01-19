import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/DailyUnitData.dart';

import '../../main.dart';
import 'ChartCardWidget.dart';

class ScrollableTabBar extends StatefulWidget{
  @override
  _ScrollableTabBarState createState() =>  _ScrollableTabBarState();
}
class _ScrollableTabBarState extends State<ScrollableTabBar> with SingleTickerProviderStateMixin {
  TabController _controller ;
  var _height = 0.0;
  @override
  void initState() {
    _controller = new TabController(vsync: this, length: 6);
    _controller.addListener((){
      setState(() {
        _height = 0.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if( _height == 0.0)  _height = MediaQuery.of(context).size.height / 7;

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 10,
          child: TabBar(
            controller: _controller,
              isScrollable: true,
              unselectedLabelColor:(  Theme.of(context).brightness == Brightness.light
    ? Colors.black
        : Colors.white).withOpacity(0.3),
              indicatorColor:
                  Theme.of(context).brightness == Brightness.light
                      ? Colors.grey
                      : Colors.white,
              tabs: [
                Tab(
                  child: Text('PM10'),
                ),
                Tab(
                  child: Text('PM2.5'),
                ),
                Tab(
                  child: Text('NO2'),
                ),
                Tab(
                  child: Text('SO2'),
                ),
                Tab(
                  child: Text('O3'),
                ),
                Tab(
                  child: Text('CO'),
                )
              ],
         ),
        ),
        Container(
          height: _height,
          child: TabBarView(
              controller: _controller,
              children: <Widget>[
            for (var index = 0; index < kInfo.value.length; index++)
              ChartCardWidget(
                  index: index,
                  changeContainer: changeDimensionContainer,
                  data: index == 0
                      ? DailyUnitData().getPM10Values()
                      : index == 1
                          ? DailyUnitData().getPM25Values()
                          : index == 2
                              ? DailyUnitData().getNO2Values()
                              : index == 3
                                  ? DailyUnitData().getSO2Values()
                                  : index == 4
                                      ? DailyUnitData().getO3Values()
                                      : DailyUnitData().getCOValues()),
          ]),
        ),
      ],
    );
  }

  changeDimensionContainer(double height){
     setState(() {
       _height = height;
     });
  }
}
