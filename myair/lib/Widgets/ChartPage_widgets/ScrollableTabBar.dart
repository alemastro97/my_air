
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:myair/Modules/DailyUnitData.dart';
import 'package:myair/Views/Graph_view/ChartPage.dart';
import 'package:myair/main.dart';
import 'package:myair/Widgets/ChartPage_widgets/ChartCardWidget.dart';

class ScrollableTabBar extends StatefulWidget{
  //List of hour sorted based on the actual
  final List<Pollution> hourSorted;
  //Constructor
  const ScrollableTabBar({Key key, this.hourSorted}) : super(key: key);

  @override
  _ScrollableTabBarState createState() =>  _ScrollableTabBarState();
}

class _ScrollableTabBarState extends State<ScrollableTabBar> with SingleTickerProviderStateMixin {

  TabController _controller ;
  var _height = 0.0;

  //Initial state to create the controller of the Tab and the first height dimension
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

    if( _height == 0.0)  _height = MediaQuery.of(context).size.height / 7; //Settings of the height when i change the tab

    return Column(
      children: [
        SizedBox( //Set the dimesion of the tabs
          height: MediaQuery.of(context).size.height / 10,
          child: TabBar(
            controller: _controller,
              isScrollable: true,
              unselectedLabelColor:(  //Color of the unselected elements based on theme of the application
                  Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white)
                    .withOpacity(0.3),
            //Color of the selected element based on the actual theme
            indicatorColor: Theme.of(context).brightness == Brightness.light
                ? Colors.grey
                : Colors.white,
            //6 tabs, one per agent
            tabs: [
                Tab(child: Text('PM10'),),
                Tab(child: Text('PM2.5'),),
                Tab(child: Text('NO2'),),
                Tab(child: Text('SO2'),),
                Tab(child: Text('O3'),),
                Tab(child: Text('CO'),),
              ],
         ),
        ),
        //Container in which is displayed the bar chart or its preview
        Container(
          height: _height,
          child: TabBarView(
              controller: _controller,
              children: <Widget>[
            for (var index = 0; index < kInfo.value.length; index++)
              ChartCardWidget( // settings of the right data on which stay tuned
                  hourSorted: widget.hourSorted,
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

  //Changer of the container dimension used by ChartCardWidget to dimension it and change the internal widget
  changeDimensionContainer(double height){
     setState(() {
       _height = height;
     });
  }
}
