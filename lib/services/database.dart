import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  // users collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future sendDailyProgress(String uid,) async {

    return userCollection.doc(uid).collection('dailyProgress').doc().set({
      'journalText': 'test text',
      'status': 'positive',
      'statusCalculation': '0.56'
    });

  }

}