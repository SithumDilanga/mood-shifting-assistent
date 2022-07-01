import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mood_shifting_assistent/services/database.dart';
import 'package:mood_shifting_assistent/utils/loading_animation.dart';

class PreviousJournals2 extends StatelessWidget {

  final uid;

  const PreviousJournals2({
    Key? key, 
    this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    DatabaseService _databaseService = DatabaseService(uid: uid);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: const Text(
          'Previous Journals',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          }, 
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _databaseService.getPreviousJournals(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {

          if(streamSnapshot.hasData) {

            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView(
                children: streamSnapshot.data!.docs.map((DocumentSnapshot document) {

                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                  DateTime formattedDate = data['timeStamp'].toDate();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 8),
                          child: Text(
                            '${formattedDate.toString()}'
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF77BF87),
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  '${data['journalText']}',
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }).toList(),
                ),
            );

          }

          return const LoadingAnimation();

        }
      ),
    );
  }
}
