import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SettingsPageWidget extends StatefulWidget{
  @override
  _SettingsPageWidgetState createState() => _SettingsPageWidgetState();
}

class _SettingsPageWidgetState extends State<SettingsPageWidget>{
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Theme.of(context).brightness == Brightness.light ? Color.fromRGBO(193, 214, 233, 1) :  Color(0xFF212121),
    appBar: AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text("Settings"),
      actions:[Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(LineAwesomeIcons.cog),
      ),],
      centerTitle: true,
    ),
    body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: Colors.purple,
                child: ListTile(
                  onTap: () {
                    //open edit profile
                  },
                  title: Text(
                    "John Doe",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: new AssetImage('assets/images/blank_profile.png'),
                  ),
                  trailing: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                elevation: 4.0,
                margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.lock_outline,
                        color: Colors.purple,
                      ),
                      title: Text("Change Password"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        //open change password
                      },
                    ),
                    _buildDivider(),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.language,
                        color: Colors.purple,
                      ),
                      title: Text("Change Language"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        //open change language
                      },
                    ),
                    _buildDivider(),
                    ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: Colors.purple,
                      ),
                      title: Text("Change Location"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        //open change location
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                "Notification Settings",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              SwitchListTile(
                activeColor: Colors.purple,
                contentPadding: const EdgeInsets.all(0),
                value: true,
                title: Text("Received notification"),
                onChanged: (val) {},
              ),
              SwitchListTile(
                activeColor: Colors.purple,
                contentPadding: const EdgeInsets.all(0),
                value: false,
                title: Text("Received newsletter"),
                onChanged: null,
              ),
              SwitchListTile(
                activeColor: Colors.purple,
                contentPadding: const EdgeInsets.all(0),
                value: true,
                title: Text("Received Offer Notification"),
                onChanged: (val) {},
              ),
              SwitchListTile(
                activeColor: Colors.purple,
                contentPadding: const EdgeInsets.all(0),
                value: true,
                title: Text("Received App Updates"),
                onChanged: null,
              ),
              const SizedBox(height: 60.0),
            ],
          ),
        ),
        Positioned(
          bottom: -20,
          left: -20,
          child: Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.purple,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 00,
          left: 00,
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.powerOff,
              color: Colors.white,
            ),
            onPressed: () {
              //log out
            },
          ),
        )
      ],
    ),

  );
}
  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }

}
