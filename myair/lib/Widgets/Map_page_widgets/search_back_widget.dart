import 'package:flutter/material.dart';
import 'package:myair/Modules/Unit.dart';
import 'package:myair/Widgets/Map_page_widgets/searchable_dropdown_widget.dart';
import 'package:myair/helper/ui_helper.dart';

class SearchBackWidget extends StatelessWidget {
  final double currentSearchPercent;

  final Function(bool) animateSearch;
  final List<Unit> stationIdList;

  final Function recenter;
  const SearchBackWidget({Key key, this.currentSearchPercent, this.animateSearch,this.stationIdList, this.recenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: realH(80),
      right: realW(27),
      child: Opacity(
        opacity: currentSearchPercent,
        child: Container(
          width: realW(320),
          height: realH(71),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: realW(17)),
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
                    size: realW(34),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: realW(30.0)),
                  child: SearchableDropdownWidget (stationIdList: stationIdList, recenter : recenter)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
