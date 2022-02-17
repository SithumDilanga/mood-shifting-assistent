import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  // users collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future sendDailyProgress(String uid,) async {

    return userCollection.doc(uid).collection('dailyProgress').doc().set({
      'journalText': 'test text',
      'status': 'positive',
      'statusCalculation': 0.41,
      'timeStamp': FieldValue.serverTimestamp(),
      'order': FieldValue.increment(1)
    });

  }

  Future getDailyProgress(String userId,) async {

    return userCollection.doc(userId).collection('dailyProgress').get().then((value) {
      print('value ${value.docs.length}');

      if(value.docs.length % 7 == 0) {

        print('week completed!');

        getWeekFromDailyProgress(userId);

      }

      return value.docs.length;
    } 

    );

  }

  Future sendWeeklyProgress(String uid, double weeklyProgress, String weeklyStatus) async {

    return userCollection.doc(uid).collection('weeklyProgress').doc().set({
      'weeklyStatus': weeklyStatus,
      'weeklyProgress': weeklyProgress,
      'timeStamp': FieldValue.serverTimestamp(),
    });

  }

  Future getWeekFromDailyProgress(String userId,) async {

    // DateTime _now = DateTime.now();
    // DateTime _start = DateTime(_now.year, _now.month, _now.day, 0, 0);
    // DateTime _end = DateTime(_now.year, _now.month, _now.day, 23, 59, 59);

    var dailProgress = [];
    double average = 0;
    double totalProgrss = 0;
    String weeklyStatus = '';

    await FirebaseFirestore.instance.collection('users').doc('Rfpm4kAiYKVwJcNNomVI').collection('dailyProgress')
    .orderBy('timeStamp', descending: true)
    .where(
      'timeStamp', isLessThan: DateTime.now()
    ).get().then((QuerySnapshot querySnapshot) {

      for(int i = 0; i < querySnapshot.docs.length; i++) {

        if(i < 7) {

          dailProgress.add(querySnapshot.docs[i]);
          // var date = DateTime.parse(querySnapshot.docs[i]['timeStamp'].toDate().toString());

          totalProgrss = totalProgrss + querySnapshot.docs[i]['statusCalculation'];

          print('dailyProgress ${querySnapshot.docs[i]['statusCalculation']}');

        } else {

          print('totalProgrss $totalProgrss');

          average = totalProgrss / 7;

          if(average >= 0.5) {
            weeklyStatus = 'positive';
          } else {
            weeklyStatus = 'negative';
          }

          sendWeeklyProgress(userId, average, weeklyStatus);

          print('average $average');

          print('exceeds the limit!');

          return average;

        }
        
      }

        // querySnapshot.docs.forEach((doc) {
        //   dailProgress.add(doc);
        //   var date = DateTime.parse(doc['timeStamp'].toDate().toString());
        //   print('dailProgress $date');
        // })

    });

    return average;

  }

}