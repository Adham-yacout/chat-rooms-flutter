import 'package:chatroom/provider/userprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/message.dart';

class MessageWidget extends StatelessWidget {

  Message message;
  MessageWidget({required this.message});
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<UserProvider>(context);
    return provider.user?.id==message.senderid?
    SentMessage(message: message):Recievemessage(message: message);
  }
 
}


class SentMessage extends StatelessWidget{
  Message message;
  SentMessage({required this.message});

  @override
  Widget build(BuildContext context) {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.end,
       children: [
         Container(
          padding: EdgeInsets.all(24),

           decoration: BoxDecoration(
               color: Colors.blue,
             borderRadius: BorderRadius.only(
               topRight:Radius.circular(12) ,
                 topLeft:Radius.circular(12) ,
               bottomLeft: Radius.circular(12),

             )
           ),
           child: Text(message.content),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Text(

           DateFormat('dd/MM, hh:mm a').format( DateTime.fromMillisecondsSinceEpoch(message.dateTime))
              ,style: TextStyle(
               color: Colors.black,
             ),textAlign: TextAlign.start,),
           ],
         )

       ],

     );
  }
}
class Recievemessage extends StatelessWidget{
  Message message;
  Recievemessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          width: 200,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topRight:Radius.circular(12) ,
                topLeft:Radius.circular(12) ,
                bottomRight: Radius.circular(12),

              )

          ),
          child:  Text(message.content,style:TextStyle(color: Colors.white)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text( DateFormat('dd/MM, hh:mm a').format( DateTime.fromMillisecondsSinceEpoch(message.dateTime)),style: TextStyle(
              color: Colors.black,
            ),textAlign: TextAlign.end,),
          ],
        )


      ],

    );
  }
}