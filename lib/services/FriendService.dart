import 'dart:ui';
import 'package:wecycle/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendService
{
  final String uid;
  final CollectionReference friendsCollection;
  static final String FRIEND_COLLECTION_NAME = "friends";
  static final String FRIEND_DOCUMENT_ID = "friendsdocument";

  FriendService(this.uid):
    friendsCollection = Firestore.instance.collection('users').document(uid).collection(FRIEND_COLLECTION_NAME);


  Future<void> addFriend(User user) async{

    return friendsCollection.document(user.uid).setData(
        {
          'uid' : user.uid,
          'name': user.name,
          'email': user.email
        });
  }

  void testAddFriend() {
    User user = new User(uid: "Ic8ak2FpuabYQmx8iTh9",
        name: "",
        email: "");
    addFriend(user);
  }

}

