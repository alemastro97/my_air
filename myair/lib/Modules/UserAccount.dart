import 'package:firebase_auth/firebase_auth.dart';

class userAccount {
  final user = FirebaseAuth.instance.currentUser;
}