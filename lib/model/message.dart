import 'dart:convert';

class Message {
  static const String collectionName='message';
  String id;
  String roomId;
  String content;
  String senderid;
  String sendername;
  int dateTime;
  Message(
      {this.id = '',
      required this.roomId,
      required this.content,
      required this.dateTime,
      required this.senderid,
      required this.sendername});

  Message.fromJson(Map<String,dynamic> json):this(
    id: json['id'] as String,
    roomId: json['roomId'] as String,
    content: json['content'] as String,
    senderid: json['senderid'] as String,
    sendername: json['sendername'] as String,
    dateTime: json['dateTime'] as int,
  );
  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'roomId':roomId,
      'content':content,
      'senderid':senderid,
      'sendername':sendername,
      'dateTime':dateTime,
    };
  }
}
