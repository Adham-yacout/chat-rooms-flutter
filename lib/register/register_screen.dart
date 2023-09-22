import 'dart:async';

import 'package:chatroom/errors/firebaseerrors.dart';
import 'package:chatroom/home/Homescreen.dart';
import 'package:chatroom/register/register_navigator.dart';
import 'package:chatroom/register/register_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatroom/utils.dart' as Utils;
import 'package:provider/provider.dart';
class RegisterScreen extends StatefulWidget {
  
static const String routeName='registerscreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements RegisterNavigator {
String firstname='';

String lastname='';

String username='';

String email='';

String password='';

var formkey=GlobalKey<FormState>();
RegisterViewModel registerViewModel=RegisterViewModel();
@override
  void initState() {
    super.initState();
    registerViewModel.registerNavigator=this;
}
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context)=>registerViewModel  ,
      child: Stack(
        children:[

          Container(
color: Colors.white,
          ),
          Image(image: AssetImage('assets/images/background.png')
            ,fit:BoxFit.fill,
          width: double.infinity,),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,

            appBar: AppBar(
              elevation:0,
              backgroundColor: Colors.transparent,
              title: Text('Create Account'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                 mainAxisAlignment: MainAxisAlignment.center,
         children: [
           TextFormField(
               decoration: InputDecoration(
                 labelText: 'first Name',
               ),
          onChanged: (text){
                 firstname=text;
          },
               validator: (text){
                 if(text==null || text.trim().isEmpty)
                   {
                     return 'Please enter first name';

                   }
                 else{
                   return null;
                 }
               },
           ),
           TextFormField(
               decoration: InputDecoration(
                 labelText: 'last Name',
               ),
               onChanged: (text){
                 lastname=text;
               },
               validator: (text){
                 if(text==null || text.trim().isEmpty)
                 {
                   return 'Please enter last name';

                 }
                 else{
                   return null;
                 }
               },
           ),
           TextFormField(
             decoration: InputDecoration(
               labelText: 'user Name',
             ),
             onChanged: (text){
               username=text;
             },
             validator: (text){
               if(text==null || text.trim().isEmpty)
               {
                 return 'Please enter user name';

               }
               else{
                 return null;
               }
             },
           ),
           TextFormField(

               decoration: InputDecoration(
                 labelText: 'email ',
               ),
               onChanged: (text){
                 email=text;
               },
               validator: (text){
                 bool emailValid =
                 RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                     .hasMatch(text!);

                 if(text==null || text.trim().isEmpty)
                 {
                   return 'Please enter your email';

                 }
                 if(!emailValid)
                 {
                   return 'please enter valid email';
                 }

                   return null;

               },
           ),
           TextFormField(
               decoration: InputDecoration(
                 labelText: 'password',
               ),
               onChanged: (text){
                 password=text;
               },
               validator: (text){
                 if(text==null || text.trim().isEmpty)
                 {
                   return 'Please enter password';

                 }
                 else if(text.length<6)
                   {
                     return 'Please enter longer password';
                   }
                 else{
                   return null;
                 }
               },
           ),
            SizedBox(height: 15,),
           ElevatedButton(onPressed:(){
             validateForm();
           }, child: Text('create Account')),


         ],
                ),
              ),
            ),
          )
        ],

      ),
    );
  }

  void validateForm() async {
if(formkey.currentState?.validate() == true)
  {
   registerViewModel.registerFirebaseAuth(email.trim(), password,firstname,lastname,username);
  }
else{
  print('hamada');
}

  }

  @override
  void hideloading() {
Utils.hideloading(context);
  }

  @override
  void showloading() {
  Utils.showloading(context);
  }

  @override
  void showmessage(String message) {
    Utils.showmessage(context, message, 'ok', (context){
      Navigator.pop(context);
    } );
  }

  @override
  void gotohomescreen() {
    Timer(Duration(seconds: 1 ),(){
      Navigator.pushReplacementNamed(context, Homescreen.routeName);});
  }
}
