import 'package:myair/Widgets/Account_page_widgets/UserPageWidget.dart';

import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  var changeTopImage;

  UserPage({ Key key, this.changeTopImage,}) : super (key: key);

  @override
  Widget build(BuildContext context) => Scaffold(

    body: UserPageWidget(changeTopImage: changeTopImage),
  );
}
