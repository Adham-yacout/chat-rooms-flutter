import 'package:chatroom/model/myUsers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Databaseutils{

static CollectionReference<MyUsers> getusercollection(){
  return FirebaseFirestore.instance.collection(MyUsers.collectionName)
    .withConverter<MyUsers>(
fromFirestore: ((snapshot,options)=>MyUsers.fromJson(snapshot.data()!)),
toFirestore: (user,options)=>user.toJson());
}
  static Future<void> registeruser(MyUsers user) async{

  return  getusercollection().doc(user.id).set(user);


  }
  static Future<MyUsers?> getUser(String userId) async{
  var documentsnapshot= await getusercollection().doc(userId).get();
 return documentsnapshot.data();
  }
}