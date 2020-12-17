import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myair/Views/Home_page_views/InfoView.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/CategoriesRow.dart';
import 'package:myair/Widgets/Home_page_statistics_widgets/pie_chart.dart';


class PieChartView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          children: [
            ///Title
            Expanded(
              flex: 2,
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            'Actual Air Pollution',
                            style: GoogleFonts.rubik(fontWeight: FontWeight.w400,),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(Icons.info_outline),
                          color: Colors.black,
                          onPressed: (){
                            Navigator.of(context).push(_createRoute());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ///Pollution Fields
            Expanded(
              flex: 9,
              child: Row(
                children: <Widget>[
                  CategoriesRow(),
                  Flexible(
                    child: FractionallySizedBox(
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
                                         foregroundPainter: PieChart(
                                           width: constraint.maxWidth* 0.5,
                                           info: kInfo,
                                         ),
                                       ),
                                   ),
                                   Center(
                                     child: Container(
                                       decoration: BoxDecoration(
                                         color: Theme.of(context).brightness == Brightness.light ? Color.fromRGBO(255, 255, 255, 1) : Color(0xFF373737),
                                         shape: BoxShape.circle,
                                         boxShadow: [
                                           BoxShadow(
                                             blurRadius: 1,
                                             offset: Offset(-1,-1),
                                             color: Theme.of(context).brightness == Brightness.light ?  Colors.white : Colors.grey.shade200,
                                           ),
                                           BoxShadow(
                                             spreadRadius: -2,
                                             blurRadius: 10,
                                             offset: Offset(5,5),
                                             color: Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(0.5) : Colors.white.withOpacity(1),
                                           ),
                                         ],
                                       ),
                                       child: Center(
                                         child: Text('\$1280.20'),
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                            ),
                           ),
                        ),
                        )
                    ),
                ],
              ),
            ),
          ],
        ),
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



extension StringExtension on String{
String capitalize(){
  return "${this[0].toUpperCase()}${this.substring(1)}";
}
}