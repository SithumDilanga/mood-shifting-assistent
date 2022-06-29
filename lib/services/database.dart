import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DatabaseService {

  // userid of the user
  final String uid;

  DatabaseService({required this.uid,});

  // users collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  // posts collection reference
  final CollectionReference postsCollection = FirebaseFirestore.instance.collection('posts');

  // dailyQuote collection reference
  final CollectionReference dailyQuoteCollection = FirebaseFirestore.instance.collection('dailyQuote');


  Future sendDailyProgress(String uid, String journalText, double statusCalculation) async {

    return userCollection.doc(uid).collection('dailyProgress').doc().set({
      'journalText': journalText,
      'status': 'positive',
      'statusCalculation': statusCalculation,
      'timeStamp': FieldValue.serverTimestamp(),
      'order': FieldValue.increment(1)
    });

  }

  Future getDailyProgress(String userId,) async {

    List newDocs = [];

    return userCollection.doc(userId).collection('dailyProgress').orderBy('timeStamp', descending: false).get().then((value) {
      print('value ${value.docs.length}');

      value.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          print('newdocs ' + data.toString());
          newDocs.add(data);
      }).toList();

      if(value.docs.length % 7 == 0) {

        print('week completed!');

        getWeekFromDailyProgress(userId);

      }

      print('value.docs.last ' + newDocs.last['statusCalculation'].toString());

      return value.docs.last;
    } 

    );

  }

  Future getWeeklyProgresses(String userId,) async {

    List newDocs = [];

    return userCollection.doc(userId).collection('dailyProgress').orderBy('timeStamp', descending: true).limit(7).get();
    // .then((value) {
    //   print('value ${value.docs.length}');

    //   value.docs.map((DocumentSnapshot document) {
    //     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    //       print('newdocs ' + data.toString());
    //       newDocs.add(data['statusCalculation']);
    //   }).toList();

    //   print('newDocs $newDocs');

    //   return newDocs;
    // } 

    // );

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

          // print('dailyProgress ${querySnapshot.docs[i]['statusCalculation']}');

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

  Future getDailyPosts(String userId, double dailyProgress) async {

    // final dailyProgress = await getDailyProgress(userId);


    // print('dailyPosts ${dailyProgress}');

    // double todayProgress = dailyProgress.last['statusCalculation'];

    // print('dailyPosts ${todayProgress}');

    // if(todayProgress > 0.1) {

     return getPosts(userId, dailyProgress);

    // }

  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts(String uid, double dailyProgress) {

    dynamic posts;

    print('dailyStreamProgress ${dailyProgress}');

    if(dailyProgress >= 0.5 && dailyProgress < 0.7) {

      return FirebaseFirestore.instance.collection('posts').doc('PWLyCx7Pnc61JO0biuQ9').collection('positiveStage1').snapshots();

    } else if(dailyProgress >= 0.7 && dailyProgress < 0.8) {

      return FirebaseFirestore.instance.collection('posts').doc('PWLyCx7Pnc61JO0biuQ9').collection('positiveStage2').snapshots();

    } else if(dailyProgress >= 0.8 && dailyProgress <= 1) {

      return FirebaseFirestore.instance.collection('posts').doc('PWLyCx7Pnc61JO0biuQ9').collection('positiveStage2').snapshots();

    } else if(dailyProgress >= 0.3 && dailyProgress < 0.5) {

      return FirebaseFirestore.instance.collection('posts').doc('PWLyCx7Pnc61JO0biuQ9').collection('negativeStage1').snapshots();

    } else if(dailyProgress >= 0.2 && dailyProgress < 0.3) {

      return FirebaseFirestore.instance.collection('posts').doc('PWLyCx7Pnc61JO0biuQ9').collection('negativeStage2').snapshots();

    } else if(dailyProgress >= 0.0 && dailyProgress < 0.2) {

      return FirebaseFirestore.instance.collection('posts').doc('PWLyCx7Pnc61JO0biuQ9').collection('negativeStage3').snapshots();

    }

    print('newposts ${posts}');

    return posts;

    // print('postsStream ${postsStream}');

    // return postsStream;

  }

   // ------- creating new document for a new user and updating existing userdata ------
    Future createNewUserData({String? name, String? email, String? password}) async {
      return await userCollection.doc(uid).set({
        'uid': uid,
        'name': name,
        'email': email,
        'password': password,
      });
    }

    // ------- End creating new document for a new user and updating existing userdata ------

  Future getDailyQuote() async {

    List dailyQuote = [];
    String quote = '';

    return dailyQuoteCollection.doc('4DydfSuszSU6jwqcx7Uw').get();

    // dailyQuoteCollection.orderBy('timeStamp', descending: true).limit(1).get().then((QuerySnapshot querySnapshot) {
    //     querySnapshot.docs.forEach((doc) {
    //       dailyQuote.add(doc["quote"]);
    //       quote = doc["quote"];
    //         // print('quote ${doc["quote"]}');
    //     });
    // });

    // dailyQuoteCollection.orderBy('timeStamp', descending: true).limit(1).get().then((value) {

    //   if(value.docs.length > 0){

    //     dynamic documentData = value.docs[0];
    //     print('quote ${documentData}');  

    //     // quote = value.docs[0] as String;


    //     return value.docs[0];
    //   }

    // });
    
  }  

   Future addNewDailyQuote(String quote) async {

    dailyQuoteCollection.doc('4DydfSuszSU6jwqcx7Uw').set({
      'quote': quote,
      'timeStamp': FieldValue.serverTimestamp(),
    });

    // return dailyQuoteCollection.doc().set({
    //   'quote': quote,
    //   'timeStamp': FieldValue.serverTimestamp(),
    // }).then((value) {
      
    //   Fluttertoast.showToast(
    //     msg: "Successfully added daily quote",
    //     toastLength: Toast.LENGTH_SHORT,
    //   );

    // }).onError((error, stackTrace) {
    //     Fluttertoast.showToast(
    //       msg: "Error adding daily quote",
    //       toastLength: Toast.LENGTH_SHORT,
    //     );
    // });

  } 

  Stream<QuerySnapshot<Map<String, dynamic>>> getPreviousJournals() {

    return userCollection.doc(uid).collection('dailyProgress').snapshots();

  }
  

  // // user posts list from snapshot
  // List<Post> _postsFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc,) {
  //     print('gritie doc ' + doc.toString());

  //     if(doc.id == ) {

  //     }

  //     return Post(
  //       postLink: 'postLink'
  //     );
  //   }).toList();
  // }

  // // get posts stream
  // Stream<List<Post>> get getPosts {
  //   return postsCollection.snapshots().map(_postsFromSnapshot);
  // }

}