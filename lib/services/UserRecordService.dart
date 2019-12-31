import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wecycle/model/UserRecord.dart';

class UserRecordService
{
  final String uid;
  final CollectionReference userRecordsCollection;
  static final String USER_RECORD_COLLECTION_NAME = "user_record";
  static final String USER_RECORD_DOCUMENT_ID = "user_record";

  UserRecordService(this.uid):
    userRecordsCollection = Firestore.instance.collection('users').document(uid).collection(USER_RECORD_COLLECTION_NAME);


  Future<void> updateUserRecord(UserRecord userRecord) async
  {
    return await userRecordsCollection.document(USER_RECORD_DOCUMENT_ID).setData(
      {
        'coinCoint': userRecord.coinCount,
        'numChallengeCompleted': userRecord.numChallengeCompleted,
        'completedChallengeID': userRecord.completedChallengeID
      }
    );
  }

  Future<UserRecord> get userRecord async{
    DocumentReference docRef = userRecordsCollection.document(USER_RECORD_DOCUMENT_ID);

    DocumentSnapshot snapShot = await docRef.get();

    if(snapShot.exists)
      {
        print("Ran");
        return _userRecordFromSnapShot(snapShot);
      }
    else
      return new UserRecord(coinCount: 0, numChallengeCompleted : 0,completedChallengeID : new Map<String,bool>());

  }

  UserRecord _userRecordFromSnapShot(DocumentSnapshot snapshot)
  {
    return UserRecord(
        coinCount : snapshot.data['cointCount'],
        numChallengeCompleted : snapshot.data['numChallengeCompleted'],
        completedChallengeID : snapshot.data['completedChallengeID']
    );
  }

  void printUserRecord()
  {
    Future<UserRecord> record = userRecord;
    record.then((record)
    {
      print(record.toString());
    });
  }

  void testUpdate()
  {
    Map<dynamic,dynamic> map = {
      'test1' : true,
      'test2' : true
    };
    UserRecord record = new UserRecord(coinCount:3, numChallengeCompleted:2,completedChallengeID : map);
    updateUserRecord(record);
  }

}