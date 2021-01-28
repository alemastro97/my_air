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
    return Container(
      //Positioning of the widget based on a relative measure
      width:MediaQuery.of(context).size.width,
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
              child: Icon( // Go back to close the search option
                Icons.arrow_back,
                size:  (34 /  375.0 * MediaQuery.of(context).size.width),
              ),
            ),
          ),
          Expanded(
            child: Padding( // showing the station searcher
                padding: EdgeInsets.symmetric(horizontal: 8.0),
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
