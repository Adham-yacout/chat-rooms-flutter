import 'package:chatroom/model/myUsers.dart';

abstract class RegisterNavigator{
  // this is an abstract class works as
  // a middle man between model and view model and ui
void showloading();
void  hideloading();
void showmessage(String message);
void gotohomescreen(MyUsers user);
}