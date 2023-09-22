import 'package:chatroom/ui/addroom/addroom.dart';
import 'package:chatroom/ui/home/home_view_model.dart';
import 'package:chatroom/ui/home/home_viewmodel_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  static const String routeName = 'homescreen';

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> implements HomeNavigator{
  HomeViewModel viewModel=HomeViewModel();
  @override
  void initState() {

    super.initState();
    viewModel.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>viewModel,
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
              title: Text('Home Screen'),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.of(context).pushNamed(Addroom.routeName);
              },
              child: Icon(Icons.add),
            ),
          ),

        ],
      ),
    );
  }
}
