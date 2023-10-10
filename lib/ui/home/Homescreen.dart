import 'package:chatroom/database/database_utils.dart';
import 'package:chatroom/ui/addroom/addroom.dart';
import 'package:chatroom/ui/addroom/room_widget.dart';
import 'package:chatroom/ui/home/home_view_model.dart';
import 'package:chatroom/ui/home/home_viewmodel_navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/Rooms.dart';

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
          body: StreamBuilder<QuerySnapshot<Rooms>>(
            stream:Databaseutils.getRooms(),
            builder:(context,asyncsnapshot){
              if(asyncsnapshot.connectionState==ConnectionState.waiting)
                {
                  return Center(
                    child: CircularProgressIndicator(
                      color:  Colors.blue,
                    ),
                  );
                }
              else if(asyncsnapshot.hasError)
                {
                  return Text(asyncsnapshot.error.toString());
                }
              else{
                // has data
      var roomslist=asyncsnapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
      return GridView.builder(itemBuilder:(context,index){
        return RoomWidget(room: roomslist[index]);
      },itemCount: roomslist?.length ?? 0,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
          ),

      );
              }
            } ,
          ) ,
          ),

        ],
      ),
    );
  }
}
