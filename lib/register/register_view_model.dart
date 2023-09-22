import 'package:chatroom/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../errors/firebaseerrors.dart';

class RegisterViewModel extends ChangeNotifier{
  late RegisterNavigator registerNavigator;

void registerFirebaseAuth(String email,String password) async
{
  registerNavigator.showloading();
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    registerNavigator.hideloading();
    registerNavigator.showmessage('register succesfull!');
    registerNavigator.gotohomescreen();
  } on FirebaseAuthException catch (e) {
    if (e.code == FirebaseErros.weakpassword) {
      registerNavigator.hideloading();
      registerNavigator.showmessage('password provided is weak');

    } else if (e.code == FirebaseErros.emailused) {
      registerNavigator.hideloading();
      registerNavigator.showmessage('The account already exists for that email.');

    }
  } catch (e) {
    registerNavigator.hideloading();
    registerNavigator.showmessage('something went wrong');
  }
}

}