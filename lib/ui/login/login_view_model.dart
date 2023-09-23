import 'package:chatroom/database/database_utils.dart';
import 'package:chatroom/errors/firebaseerrors.dart';

import 'package:chatroom/model/myUsers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import 'login_navigator.dart';

class LoginViewModel extends ChangeNotifier{
  late LoginNavigator loginnavigator;
  void loginfirebasauth(String email,String password) async {
    try {
      //show loading
loginnavigator.showloading();
//fetch login data
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      //retrieve data
    var userobj=await Databaseutils.getUser(credential.user?.uid ?? '') ;
    if(userobj==null)
      {
        loginnavigator.hideloading();
        loginnavigator.showmessage('something went wrong');
      }
    else{
      //hide loading
      loginnavigator.hideloading();
      //show message
      loginnavigator.showmessage("login succesfull");
      //navigation
      loginnavigator.gotohomescreen(userobj);
    }


    } on FirebaseAuthException catch (e) {

      if (e.code == FirebaseErros.emailnotfound) {
        loginnavigator.hideloading();
        loginnavigator.showmessage('No user found for that email');
      } else if (e.code == FirebaseErros.wrongpassword) {
        print('hello');
        loginnavigator.hideloading();
        loginnavigator.showmessage('Wrong password provided for that user');

      }
      else{
        loginnavigator.hideloading();
        loginnavigator.showmessage('something went wrong try again');
      }
    }
  }
}