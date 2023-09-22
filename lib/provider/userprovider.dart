import 'package:chatroom/database/database_utils.dart';
import 'package:chatroom/model/myUsers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  MyUsers? user;
  User? firebaseUser;
  UserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    inituser();
  }
  inituser() async {
    if (firebaseUser != null) {
      user = await Databaseutils.getUser(firebaseUser?.uid ?? '');
    }
  }
}
