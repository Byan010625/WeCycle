import 'dart:collection';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:wecycle/model/UserRecord.dart';
import 'package:wecycle/services/FriendService.dart';
import 'package:wecycle/services/UserRecordService.dart';
import 'package:wecycle/services/UserService.dart';
import 'package:wecycle/model/User.dart';

class AuthService{

  static final FirebaseAuth _authentication = FirebaseAuth.instance;

  User userValueFromFirebase(FirebaseUser user)
  {
    return User(uid: user.uid);
  }

  Future<User> registerWithEmailAndPassword(String email, String password) async
  {
    try {
      AuthResult resultInfo = await _authentication
          .createUserWithEmailAndPassword(email: email, password: password);

      FirebaseUser signedInUser = resultInfo.user;

      await UserService(signedInUser.uid).updateUser(new User(uid:signedInUser.uid,name:"",email:email));
      FriendService(signedInUser.uid);
      await UserRecordService(signedInUser.uid).updateUserRecord(new UserRecord(coinCount: 0, numChallengeCompleted:0,completedChallengeID: new HashMap()));
      return userValueFromFirebase(signedInUser);
    }
    catch(error)
    {
      print("Error: " + error.toString());
      return null;
    }
  }

  Future<FirebaseUser> signInWithEmailAndPassword(String email, String password) async
  {
    try{
      AuthResult resultInfo = await _authentication.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = resultInfo.user;
      return user;
    }
    catch(error)
    {
      error.toString();
      return null;
    }
  }


}

main()
{
  AuthService auth = new AuthService();
  auth.registerWithEmailAndPassword("tom@gmail.com", "hiiiiiiiiiii");

}