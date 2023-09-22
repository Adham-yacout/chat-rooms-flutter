import 'package:chatroom/model/myUsers.dart';

abstract class LoginNavigator{
  void showloading();
  void hideloading();
  void showmessage(String message);
  void gotohomescreen(MyUsers user);
}