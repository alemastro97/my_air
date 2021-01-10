
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myair/Modules/PollutantAgent.dart';
import 'package:myair/Views/Home_page_views/InfoView.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/PieChart.dart';


import '../../main.dart';
import 'AgentListWidget.dart';
import 'GridAgentWidget.dart';

class GraphWidget extends StatelessWidget{
  var _aqi = 0;
  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQuery = MediaQuery.of(context);
    _aqi = PollutantAgent().getAqi(kInfo.value.elementAt(0).value.amount,kInfo.value.elementAt(1).value.amount,kInfo.value.elementAt(2).value.amount, kInfo.value.elementAt(3).value.amount, kInfo.value.elementAt(4).value.amount, kInfo.value.elementAt(5).value.amount);
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light ? Color.fromRGBO(193, 214, 233, 1) :  Color(0xFF212121),
      body:  Stack(
        children: [
          SafeArea(
            child: Column(
              children:<Widget>[
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding:  EdgeInsets.all(_mediaQuery.size.width/30),
                    child: Container(

                      //  width: _mediaQuery.size.width,
                      // height: _mediaQuery.size.height/3.5,
                      child: Card(
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_mediaQuery.size.width/20),
                        ),
                        child: Column(
                          children: <Widget>[
                            ///Title with info icon
                            Flexible(flex: 2,
                              child: Row (
                                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                                children: <Widget>[
                                  ///Title
                                  Expanded(
                                    flex: 9,
                                    child:Container(
                                      padding: EdgeInsets.all(MediaQuery.of(context).size.width/100),
                                      child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Text(
                                          'Actual Air Pollution',
                                          style: GoogleFonts.rubik(fontWeight: FontWeight.w400,),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ///Info Icon
                                  Flexible(flex: 1,child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: IconButton(
                                      icon: Icon(Icons.info_outline),
                                      color: Colors.black,
                                      onPressed: (){
                                        Navigator.of(context).push(_createRoute());
                                      },
                                    ),
                                  ),),
                                ],
                              ),
                            ),
                            ///List of agents + graph
                            Flexible(
                              flex: 8,
                              child: Row (
                                children: <Widget>[
                                  ///List of agents
                                  Flexible(
                                    flex:1,
                                    child: AgentListWidget(),
                                  ),
                                  ///Graph
                                  Flexible(
                                    flex:1,
                                    child:  FractionallySizedBox(
                                      widthFactor: 1,
                                      child: Container(
                                        child: LayoutBuilder(
                                          builder: (context, constraint) => FractionallySizedBox(
                                            heightFactor: 0.5, widthFactor: 0.5,
                                            child:Container(
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(193, 214, 233, 1),
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    spreadRadius: -10,
                                                    blurRadius: 17,
                                                    offset: Offset(-5,-5),
                                                    color: Colors.white,
                                                  ),
                                                  BoxShadow(
                                                    spreadRadius: -2,
                                                    blurRadius: 10,
                                                    offset: Offset(7,7),
                                                    color: Color.fromRGBO(146,182,216,1),
                                                  ),
                                                ],
                                              ),
                                              child: Stack(
                                                children: [
                                                  Center(
                                                    child: CustomPaint(
                                                      child: Center(),
                                                      foregroundPainter:
                                                          PieChart(
                                                        width: constraint
                                                                .maxWidth *
                                                            0.5,
                                                        info: kInfo.value,
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? Color.fromRGBO(
                                                                255,
                                                                255,
                                                                255,
                                                                1)
                                                            : Color(0xFF373737),
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 1,
                                                            offset:
                                                                Offset(-1, -1),
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? Colors.white
                                                                : Colors.grey
                                                                    .shade200,
                                                          ),
                                                          BoxShadow(
                                                            spreadRadius: -2,
                                                            blurRadius: 10,
                                                            offset:
                                                                Offset(5, 5),
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? Colors.black
                                                                    .withOpacity(
                                                                        1)
                                                                : Colors.white
                                                                    .withOpacity(
                                                                        1),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Center(
                                                        child: FractionallySizedBox(
                                                          heightFactor: 0.9,
                                                          widthFactor: 0.9,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                            ),
                                                            child: CircleAvatar(

                                                              //  fit: BoxFit.fill,
                                                                backgroundImage: _aqi >= 0 && _aqi <= 50
                                                                    ? AssetImage(
                                                                        'assets/images/PollutionIcons/Good.png')
                                                                    : (_aqi >= 51 &&
                                                                            _aqi <=
                                                                                100
                                                                        ? AssetImage(
                                                                            'assets/images/PollutionIcons/Moderate.png')
                                                                        : (_aqi >= 101 &&
                                                                                _aqi <= 150
                                                                            ? AssetImage('assets/images/PollutionIcons/UnhealthyForSensitiveGroups.png')
                                                                            : (_aqi >= 151 && _aqi <= 200
                                                                                ? AssetImage('assets/images/PollutionIcons/Unhealthy.png')
                                                                                : (_aqi >= 201 && _aqi <= 300
                                                                                    ? AssetImage('assets/images/PollutionIcons/VeryUnhealthy.png')
                                                                                    : AssetImage('assets/images/PollutionIcons/Hazardous.png'))))),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    padding:  EdgeInsets.only(top:MediaQuery.of(context).size.width/100,left: MediaQuery.of(context).size.width/100,right: MediaQuery.of(context).size.width/100,bottom: MediaQuery.of(context).size.width/20),
                    child: Card(
                      color: Theme.of(context).brightness == Brightness.light ? Colors.white60 : Colors.grey,
                      elevation: 1.0,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(_mediaQuery.size.width/20),
                      ),
                      child: GridAgentWidget(),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

}
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => InfoView(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
