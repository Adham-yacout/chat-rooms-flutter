import 'package:chatroom/home/Homescreen.dart';
import 'package:chatroom/login/login_screen.dart';
import 'package:chatroom/register/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(myapp());
}

class myapp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        RegisterScreen.routeName:(context)=>RegisterScreen(),
        LoginScreen.routeName:(context)=>LoginScreen(),
        Homescreen.routeName:(context)=>Homescreen(),
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
