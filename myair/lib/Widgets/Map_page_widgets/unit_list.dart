import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/sensor.dart';
import 'package:myair/Modules/unit.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:myair/Services/Database_service/database_helper.dart';

class UnitList extends StatefulWidget {

  final List<Sensor> sensorList;
  final String title;

  UnitList(this.sensorList, this.title);

  @override
  State<StatefulWidget> createState() {

    return UnitListState(sensorList, title);
  }
}

class UnitListState extends State<UnitList> {

  List<charts.Series<Task,String>> _seriesPieData;
  List<charts.Series<Pollution,String>> _seriesData;

  _generateData() {

    var data1 = [
      new Pollution(1980, 'USA', 30),
      new Pollution(1980, 'Asia', 40),
      new Pollution(1980, 'Europe', 10),
    ];
    var data2 = [
      new Pollution(1985, 'USA', 100),
      new Pollution(1980, 'Asia', 150),
      new Pollution(1985, 'Europe', 80),
    ];
    var data3 = [
      new Pollution(1985, 'USA', 200),
      new Pollution(1980, 'Asia', 300),
      new Pollution(1985, 'Europe', 180),
    ];

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution,_) => pollution.place,
        measureFn: (Pollution pollution,_) => pollution.quantity,
        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution,_) => pollution.place,
        measureFn: (Pollution pollution,_) => pollution.quantity,
        id: '2018',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff109618)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution,_) => pollution.place,
        measureFn: (Pollution pollution,_) => pollution.quantity,
        id: '2019',
        data: data3,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      ),
    );

    var pieData=[
      new Task('Work', 35.8, Color(0xff3366cc)),
      new Task('Eat', 8.3, Color(0xff3366cc)),
      new Task('Commute', 10.8, Color(0xff3366cc)),
      new Task('TV', 15.6, Color(0xff3366cc)),
      new Task('Sleep', 19.2, Color(0xff3366cc)),
      new Task('Other', 10.3, Color(0xff3366cc)),
    ];

    _seriesPieData.add(
        charts.Series(
          data: pieData,
          domainFn: (Task task,_)=> task.task,
          measureFn: (Task task,_) => task.taskvalue,
          colorFn: (Task task,_) =>
              charts.ColorUtil.fromDartColor(task.colorval),
          id:'Daily Task',
          labelAccessorFn: (Task row,_) => '${row.taskvalue}',
        )
    );
  }

  @override
  void initState() {
    super.initState();
    _seriesPieData = List<charts.Series<Task, String>>();
    _seriesData = List<charts.Series<Pollution, String>>();
    _generateData();
  }
  DatabaseHelper databaseHelper = DatabaseHelper();

  final List<Sensor> sensorList;
  final String title;

  UnitListState(this.sensorList, this.title);

  List<Unit> unitList;
  int count = 0;
  int result;

  @override
  Widget build(BuildContext context) {

    if (unitList == null) {
      updateListView(this.sensorList);
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(

          appBar: AppBar(
            bottom: TabBar(
                tabs:[
                  Tab(
                    icon: Icon(Icons.add_a_photo),
                  ),
                  Tab(
                    icon: Icon(Icons.add_a_photo),
                  )
                ]
            ),
          ),

          body: TabBarView(
              children: [
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                        child: Center(
                            child: Column(
                                children: <Widget>[
                                  Text(
                                    'Daily emissions',
                                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                    child: charts.BarChart(
                                      _seriesData,
                                      animate: true,
                                      barGroupingType: charts.BarGroupingType.grouped,
                                      animationDuration: Duration(seconds: 2),
                                    ),
                                  )
                                ]
                            )
                        )
                    )
                ),

                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                        child: Center(
                            child: Column(
                                children: <Widget>[
                                  Text(
                                    'Daily sensor data',
                                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10.0,),
                                  Expanded(
                                    child: charts.PieChart(
                                        _seriesPieData,
                                        animate: true,
                                        animationDuration: Duration(seconds: 3),
                                        behaviors: [
                                          new charts.DatumLegend(
                                            outsideJustification: charts.OutsideJustification.endDrawArea,
                                            horizontalFirst: false,
                                            desiredMaxRows: 2,
                                            cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                                            entryTextStyle: charts.TextStyleSpec(
                                                color: charts.MaterialPalette.purple.shadeDefault,
                                                fontFamily: 'Georgia',
                                                fontSize: 11),
                                          )
                                        ],
                                        defaultRenderer: new charts.ArcRendererConfig(
                                            arcWidth: 100,
                                            arcRendererDecorators: [
                                              new charts.ArcLabelDecorator(labelPosition: charts.ArcLabelPosition.inside)
                                            ]
                                        )
                                    ),
                                  )
                                ]
                            )
                        )
                    )
                )
              ]
          )
      ),
    );
  }

  ListView getSensorListView() {

    TextStyle titleStyle = Theme.of(context).textTheme.subtitle1;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.keyboard_arrow_right),
            ),

            title: Text(this.unitList[position].idunit, style: titleStyle,),
            subtitle: Text(this.unitList[position].unit + " (" + count.toString() + ")"),

            onTap: () {
              //navigateToDetail(this.sensorDataList[position], "Sensor detail");
            },
          ),
        );
      },
    );
  }

  void updateListView(List<Sensor> sensor) {
    Future<List<Unit>> viewList = getUnitList(sensor);

    viewList.then((viewList) {
      setState(() {
        this.unitList = viewList;
        this.count = viewList.length;

        print("------------------------ Number of units: " + this.count.toString());
      });
    });
  }
}

Future<List<Unit>> getUnitList(List<Sensor> sensor) async {
  var idunit = "";
  List<Unit> unitList = List();
  Unit unit;

  for (var sensoritem in sensor) {

    if (idunit != sensoritem.idunit) {
      unit = new Unit(sensoritem.id, sensoritem.unit, sensoritem.idunit, double.parse(sensoritem.lat), double.parse(sensoritem.lng));
      unitList.add(unit);
    }

    idunit = unit.idunit;
  }

  return unitList;
  print("Unit list loaded (" + unitList.length.toString() + ")");
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}