import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wecycle/model/User.dart';

class UserService{

  final String uid;
  final CollectionReference usersCollection;

  UserService(this.uid):
    usersCollection = Firestore.instance.collection('users');

  Future<void> updateUser(User user) async{
    return await usersCollection.document(uid).setData(
      {
        'uid' : user.uid,
        'name' : user.name,
        'email' : user.email,
      }
    );
  }








}