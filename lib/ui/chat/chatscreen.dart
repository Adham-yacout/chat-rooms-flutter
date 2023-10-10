import 'package:chatroom/model/myUsers.dart';
import 'package:chatroom/provider/userprovider.dart';
import 'package:chatroom/ui/chat/chat_navigator.dart';
import 'package:chatroom/ui/chat/chatscreenviewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatroom/utils.dart' as Utils;
import '../../model/Rooms.dart';
import '../../model/message.dart';
import 'messagewidget.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements ChatNavigator {
  ChatScreenViewModel viewModel = ChatScreenViewModel();
  String messagecontent = '';
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)?.settings.arguments as Rooms;
    var provider = Provider.of<UserProvider>(context);
    viewModel.room = arg;
    viewModel.currentuser = provider.user!;
    viewModel.listenforupdatemessage();


    return ChangeNotifierProvider(
      create: (context) => viewModel,
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
              title: Text(arg.title),
              centerTitle: true,
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 52),
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 5,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot<Message>>(
                      stream: viewModel.streamMessage,
                      builder: (context, asyncSnapshot) {
                        if (asyncSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (asyncSnapshot.hasError) {
                          return Text(asyncSnapshot.error.toString());
                        } else {
                          var messagelist = asyncSnapshot.data?.docs
                                  .map((doc) {
                          print('hamada :${doc.data()}');
                          return doc.data();
                          } )
                                  .toList() ?? [];

                          return ListView.builder(
                            itemBuilder: (context, index) {
                              return MessageWidget(message:messagelist[index]);
                            },
                            itemCount: messagelist.length,
                          );
                        }
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          onChanged: (text) {
                            messagecontent = text;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              hintText: 'type a message',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12)))),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            viewModel.sendmessage(messagecontent);
                          },
                          child: Row(
                            children: [
                              Text('Send'),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.send_outlined),
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void showMessage(String message) {
    Utils.showmessage(context, message, 'Ok', (context) {
      Navigator.pop(context);
    });
  }
  Future<void> printThings(Stream<QuerySnapshot<Message>> data) async {
    await for (var x in data) {

      print(x.docs.map((doc) => doc.data()));
    }
  }
   // prints "ok".
  @override
  void clearMessage() {
    controller.clear();
  }
}
