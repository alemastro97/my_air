import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/Unit.dart';

import 'SearchBackWidget.dart';

class SearchWidget extends StatelessWidget {
  final double currentExplorePercent;

  final double currentSearchPercent;

  final Function(bool) animateSearch;

  final bool isSearchOpen;

  final Function(DragUpdateDetails) onHorizontalDragUpdate;

  final Function() onPanDown;
  final  Function(Unit station) recenter;
  final List<Unit> stationIdList;
  const SearchWidget(
      {Key key,
      this.currentExplorePercent,
      this.currentSearchPercent,
      this.animateSearch,
      this.isSearchOpen,
      this.onHorizontalDragUpdate,
      this.onPanDown,this.stationIdList,this.recenter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80.0/  815.0 * MediaQuery.of(context).size.height,
      right: (((68.0 - 320) - (68.0 * currentExplorePercent) + (347 - 68.0) * currentSearchPercent)  /  375.0 * MediaQuery.of(context).size.width),
      child: GestureDetector(
        onTap: () {
          animateSearch(!isSearchOpen);
        },
        onPanDown: (_) => onPanDown,
        onHorizontalDragUpdate: onHorizontalDragUpdate,
        onHorizontalDragEnd: (_) {
         _dispatchSearchOffset();
        },
        child: Container(
          width: 320/  815.0 * MediaQuery.of(context).size.width,
          height: 71 /  815.0 * MediaQuery.of(context).size.height,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal:  (17 /  375.0 * MediaQuery.of(context).size.width)),
          child: currentSearchPercent != 1.0 ?

         Opacity(
           opacity: 1.0 - currentSearchPercent,
           child: Icon(
                  Icons.search,
                  size:  (34 /  375.0 * MediaQuery.of(context).size.width),
                ), )
          :
                SearchBackWidget(
                  stationIdList: stationIdList,
                  recenter:recenter ,
                  currentSearchPercent: currentSearchPercent,
                  animateSearch: animateSearch,
                ),




          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light ? Colors.white : Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular( (36 /  375.0 * MediaQuery.of(context).size.width))),
              boxShadow: [
                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3), blurRadius:  (36 /  375.0 * MediaQuery.of(context).size.width)),
              ])),
    ));
  }

  /// dispatch Search state
  ///
  /// handle it by [isSearchOpen] and [currentSearchPercent]
  void _dispatchSearchOffset() {
    if (!isSearchOpen) {
      if (currentSearchPercent == 1.0) {
        animateSearch(true);
      } else {
        animateSearch(false);
      }
    }
  }
}
