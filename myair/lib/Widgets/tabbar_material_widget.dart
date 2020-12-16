import 'package:flutter/material.dart';

class TabBarMaterialWidget extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChangedTab;

  const TabBarMaterialWidget({
    @required this.index,
    @required this.onChangedTab,
    Key key,
  }) : super(key: key);

  @override
  _TabBarMaterialWidgetState createState() => _TabBarMaterialWidgetState();
}

class _TabBarMaterialWidgetState extends State<TabBarMaterialWidget> {
  @override
  Widget build(BuildContext context) {
    final placeholder = Opacity(
      opacity: 0,
      child: IconButton(icon: Icon(Icons.home_outlined), onPressed: null),
    );

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildTabItem(
            index: 0,
            icon: Icon(Icons.stacked_bar_chart),
          ),
          buildTabItem(
            index: 1,
            icon: Icon(Icons.map_outlined),
          ),
          placeholder,
          buildTabItem(
            index: 2,
            icon: Icon(Icons.account_circle),
          ),
          buildTabItem(
            index: 3,
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }

  Widget buildTabItem({
    @required int index,
    @required Icon icon,
  }) {
    final isSelected = index == widget.index;

    return IconTheme(
      data: IconThemeData(
        color: isSelected ? Colors.red : Colors.black,
      ),
      child: IconButton(
        icon: icon,
        onPressed: () => widget.onChangedTab(index),
      ),
    );
  }
}
