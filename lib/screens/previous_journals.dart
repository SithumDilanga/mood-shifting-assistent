import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mood_shifting_assistent/models/uid.dart';
import 'package:mood_shifting_assistent/services/database.dart';
import 'package:mood_shifting_assistent/utils/loading_animation.dart';
import 'package:provider/provider.dart';

class PreviousJournals extends StatelessWidget {

  final uid;

  const PreviousJournals({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    DatabaseService _databaseService = DatabaseService(uid: uid);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Previous Journals'
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _databaseService.getPreviousJournals(),
        //stream: FirebaseFirestore.instance.collection('users').doc(uid).collection('dailyProgress').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {

          if(streamSnapshot.hasData) {
            print('previousJournals ${streamSnapshot.data!.docs[0]['journalText']}');

            return ListView(
              children: streamSnapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['journalText']),
                );
              }).toList(),
            );

          }

          return const LoadingAnimation();

        }
      ),
    );
  }
}
