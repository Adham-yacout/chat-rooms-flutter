import 'package:chatroom/database/database_utils.dart';
import 'package:chatroom/model/Rooms.dart';
import 'package:chatroom/ui/addroom/AddRoomNavigator.dart';
import 'package:flutter/cupertino.dart';

class AddRoomViewModel extends ChangeNotifier {
  late AddRoomNavigator navigator;
  Future<void> addRoom(String roomtitle, String roomdescription, String categoryid)
  async {

    Rooms room=Rooms(Roomid: '',
        title: roomtitle,
        description: roomdescription,
        categoryid: categoryid);
    try{
      navigator.showloading();
      var createdroom= await Databaseutils.addRoomtofirestore(room);
      navigator.hideloading();
      navigator.showmessage('Room was added succesfully');
      navigator.showloading();
      navigator.navigatetoHome();
      navigator.hideloading();

    }
    catch(e){
      navigator.hideloading();
      navigator.showmessage(e.toString());

    }

  }
}
