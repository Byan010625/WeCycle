
class UserRecord
{
  final int coinCount;
  final int numChallengeCompleted;
  final Map<dynamic,dynamic> completedChallengeID;

  UserRecord({this.coinCount,this.numChallengeCompleted,this.completedChallengeID});

  @override
  String toString() {
    // TODO: implement toString
    return 'Coin Count: ' + coinCount.toString() + " Number of Challenges Completed" + numChallengeCompleted.toString() + "IDs of Challenges completed: " + completedChallengeID.toString();
  }

}