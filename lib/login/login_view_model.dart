import 'package:chatroom/errors/firebaseerrors.dart';
import 'package:chatroom/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import '../errors/firebaseerrors.dart';
class LoginViewModel extends ChangeNotifier{
  late LoginNavigator loginnavigator;
  void loginfirebasauth(String email,String password) async {
    try {
loginnavigator.showloading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      loginnavigator.hideloading();
      loginnavigator.showmessage("login succesfull");
      loginnavigator.gotohomescreen();

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