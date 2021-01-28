
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myair/Widgets/Login_page_widgets/LoginPageWidget.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomPadding: true,
    body: LoginPageWidget(),
  );
}
