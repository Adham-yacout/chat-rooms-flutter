import 'package:chatroom/database/database_utils.dart';
import 'package:chatroom/model/Rooms.dart';
import 'package:chatroom/model/message.dart';
import 'package:chatroom/model/myUsers.dart';
import 'package:chatroom/provider/userprovider.dart';
import 'package:chatroom/ui/chat/chat_navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ChatScreenViewModel extends ChangeNotifier{
late ChatNavigator  navigator;
late MyUsers currentuser;
late Rooms room;
 late Stream<QuerySnapshot<Message>> streamMessage;
void sendmessage(String content) async {
  Message message=Message(
      roomId: room.Roomid,
      content: content,
      dateTime: DateTime.now().millisecondsSinceEpoch,
      senderid: currentuser.id,
      sendername: currentuser.username);
  try{
    var result= await Databaseutils.insertmessage(message);
    //clear message
    navigator.clearMessage();
  }catch(error){
     navigator.showMessage(error.toString());
  }

}
void listenforupdatemessage()
{  print(room.Roomid);
  streamMessage= Databaseutils.getMessagesfromfirestore(room.Roomid);
}

}