


import 'package:chatroom/provider/userprovider.dart';
import 'package:chatroom/ui/addroom/addroom.dart';
import 'package:chatroom/ui/chat/chatscreen.dart';
import 'package:chatroom/ui/home/Homescreen.dart';
import 'package:chatroom/ui/login/login_screen.dart';
import 'package:chatroom/ui/register/register_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context)=>UserProvider(),
      child: myapp()));
}

class myapp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var userprovider=Provider.of<UserProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        RegisterScreen.routeName:(context)=>RegisterScreen(),
        LoginScreen.routeName:(context)=>LoginScreen(),
        Homescreen.routeName:(context)=>Homescreen(),
        Addroom.routeName:(context)=>Addroom(),
        ChatScreen.routeName:(context)=>ChatScreen(),
      },
      initialRoute: userprovider.firebaseUser==null?
      LoginScreen.routeName:Homescreen.routeName,
    );
  }
}
