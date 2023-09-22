import 'dart:async';

import 'package:chatroom/model/myUsers.dart';
import 'package:chatroom/provider/userprovider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatroom/utils.dart' as Utils;
import 'package:provider/provider.dart';

import '../home/Homescreen.dart';
import '../register/register_screen.dart';
import 'login_navigator.dart';
import 'login_view_model.dart';
class LoginScreen extends StatefulWidget {
  static const String routeName='loginscreen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  var formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  LoginViewModel viewmodel=LoginViewModel();
  @override
  void initState() {
 
    super.initState();
    viewmodel.loginnavigator=this;

  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> viewmodel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Image(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text('Login'),
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
                        labelText: 'Email',
                      ),
                      onChanged: (text) {
                        email = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter Email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      onChanged: (text) {
                        password = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter password';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          validateForm();
                        },
                        child: Text('Login')),
                    TextButton(onPressed: (){
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    }, child: Text('Create Account'))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void validateForm() {
 if(formkey.currentState?.validate()==true)
   { //login
     viewmodel.loginfirebasauth(email.trim(), password);
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
    Utils.showmessage(context, message, "ok", (context){
   Navigator.pop(context);
    });
  }

  @override
  void gotohomescreen(MyUsers user) {

    var userprovider=Provider.of<UserProvider>(context,listen: false);
    userprovider.user=user;
    Timer(Duration(seconds: 1),(){
      Navigator.pushReplacementNamed(context, Homescreen.routeName);});

  }
}
