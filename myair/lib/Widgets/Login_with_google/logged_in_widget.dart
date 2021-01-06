import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myair/Modules/UserAccount.dart';
import 'package:myair/Services/Google_Service/GoogleSignIn.dart';
import 'package:provider/provider.dart';

class LoggedInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  //  userAccount user = userAccount();

    return Container(
      alignment: Alignment.center,
      color: Colors.blueGrey.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Logged In',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          CircleAvatar(
            maxRadius: 25,
          //  backgroundImage: NetworkImage(user.user.photoURL),
          ),
          SizedBox(height: 8),
          Text(
            'Name: ',// + user.user.displayName,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            'Email: ' ,//+ user.user.email,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              print('LogoutPressed');
              final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
            child: Text('Logout'),
          )
        ],
      ),
    );
  }
}