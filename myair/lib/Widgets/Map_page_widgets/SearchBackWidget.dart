import 'package:flutter/material.dart';
import 'package:myair/Modules/Unit.dart';
import 'package:myair/Widgets/Map_page_widgets/SearchableDropdownWidget.dart';


class SearchBackWidget extends StatelessWidget {
  final double currentSearchPercent;

  final Function(bool) animateSearch;
  final List<Unit> stationIdList;

  final Function recenter;
  const SearchBackWidget({Key key, this.currentSearchPercent, this.animateSearch,this.stationIdList, this.recenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return/*Positioned(
      bottom: realH(80),
      right: realW(27),
      child: Opacity(
        opacity: currentSearchPercent,
        child:*/ Container(
          width: (320 /  375.0 * MediaQuery.of(context).size.width),
          height: (71 /  815.0 * MediaQuery.of(context).size.height),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left:  (17 /  375.0 * MediaQuery.of(context).size.width)),
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  animateSearch(false);
                },
                child: Transform.scale(
                  scale: currentSearchPercent,
                  child: Icon(
                    Icons.arrow_back,
                    size:  (34 /  375.0 * MediaQuery.of(context).size.width),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: (30.0 /  375.0 * MediaQuery.of(context).size.width)),
                  child: SearchableDropdownWidget (stationIdList: stationIdList, recenter : recenter)
                ),
              )
            ],
          ),
      //  ),
     // ),
    );
  }
}
