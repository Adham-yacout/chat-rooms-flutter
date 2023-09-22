import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showloading(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              Text('loading.......'),
            ],
          ),
        );
      });
}
void hideloading(BuildContext context){
  Navigator.pop(context);
}
void showmessage(BuildContext context, String message,
    String posActionText,Function posActionFun,
{String? negActionText,Function? negActionFun}
    )
{
showDialog(context: context, builder: (context){
  return AlertDialog(
    content: Text(message),
    actions: [
    TextButton(onPressed: (){
      posActionFun(context);
    }, child: Text(posActionText))
    ],
  );
});
}