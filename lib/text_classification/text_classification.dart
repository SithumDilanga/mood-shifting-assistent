import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mood_shifting_assistent/services/shared_pref.dart';
import 'package:mood_shifting_assistent/models/uid.dart';
import 'package:mood_shifting_assistent/services/shared_pref.dart';
import 'package:mood_shifting_assistent/text_classification/classifier.dart';
import 'package:mood_shifting_assistent/services/database.dart';
import 'package:provider/provider.dart';

class TextClassification extends StatefulWidget {

  final String uid;

  const TextClassification({ Key? key, required this.uid }) : super(key: key);

  @override
  _TextClassificationState createState() => _TextClassificationState();
}

class _TextClassificationState extends State<TextClassification> {

  late TextEditingController _textController;
  late Classifier _classifier;
  late List<Widget> _children;
  String journalText = '';
  dynamic prediction;

  double dailyProgressValue = 0.0;

  final DatabaseService _databaseService = DatabaseService(uid: 'null');

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _classifier = Classifier();
    _children = [];
    _children.add(Container());

    init();
    
  }

  void init() async {
    dailyProgressValue = SharedPref.getDailyProgress()!;
  }

  @override
  Widget build(BuildContext context) {

    print('dailyProgressValue $dailyProgressValue');

    return Material(
      child : Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: const Text('Text classification'),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: null,
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

            if(snapshot.hasData) {

              dynamic dailyPosts = snapshot.data!.data();

              print('fuck ${dailyPosts['posts']}');

            }

            return FutureBuilder(
              future: _databaseService.getDailyProgress(widget.uid),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        
                if (snapshot.hasData) {
        
                  // List dailyProgress = snapshot.data;

                  Map<String, dynamic> snapshotData = snapshot.data!.data() as Map<String, dynamic>;

                  double dailyProgress = snapshotData['statusCalculation'];
        
                  print('bitch ${dailyProgress}');
        
                  return StreamBuilder<QuerySnapshot>(
                  stream: _databaseService.getPosts(widget.uid, dailyProgress),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        
                    if(streamSnapshot.hasData) {
        
                      // dynamic posts = streamSnapshot.data?.data();
        
                      print('streamSnapshot ${streamSnapshot.data!.docs[0]['title']}');
                    }
        
                    return FutureBuilder(
                      future: null,//_databaseService.getWeekFromDailyProgress('Rfpm4kAiYKVwJcNNomVI'),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                
                        if (snapshot.hasData) {
                
                          print('yoyo ${snapshot.data[0]['status']}');
                
                        }
                
                        return Container(
                          padding: const EdgeInsets.all(4),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                  child: ListView.builder(
                                itemCount: _children.length,
                                itemBuilder: (_, index) {
                                  return _children[index];
                                },
                              )),
                              ElevatedButton(
                                child: const Text(
                                  'Send'
                                ),
                                onPressed: () async {

                                  print('objectNew ${_textController.text}');
                
                                  _databaseService.sendDailyProgress(
                                    widget.uid,
                                    journalText,
                                    prediction[1]
                                  );
                                  // _databaseService.getWeekFromDailyProgress('Rfpm4kAiYKVwJcNNomVI');
                
                                  // await FirebaseFirestore.instance.collection('users').doc('Rfpm4kAiYKVwJcNNomVI').collection('dailyProgress').get().then((QuerySnapshot querySnapshot) => {
                                  //   querySnapshot.docs.forEach((doc) {
                                  //     // dailProgress.add(doc);
                                  //     print('dailProgress ${doc['status']}');
                                  //   })
                                  // });
                
                                }, 
                              ),
                              ElevatedButton(
                                child: const Text(
                                  'get dailyPosts'
                                ),
                                onPressed: () async {
                
                                  // dynamic length = await _databaseService.getDailyProgress('Rfpm4kAiYKVwJcNNomVI');
                
                                  // print('length $length');
                
                                  // _databaseService.getWeekFromDailyProgress('Rfpm4kAiYKVwJcNNomVI');
                                  _databaseService.getPosts(
                                    'Rfpm4kAiYKVwJcNNomVI',
                                    prediction[1]
                                  );
                
                                }, 
                              ),
                              // ElevatedButton(
                              //   child: const Text(
                              //     'getDailyPosts'
                              //   ),
                              //   onPressed: () async {
                
                              
                              //     _databaseService.getDailyPosts('Rfpm4kAiYKVwJcNNomVI');
                
                              //   }, 
                              // ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.orangeAccent)),
                                child: Row(children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      decoration: const InputDecoration(
                                          hintText: 'Write some text here'),
                                      controller: _textController,
                                    ),
                                  ),
                                  TextButton(
                                    child: const Text('Classify'),
                                    onPressed: () {
                                      
                                      final text = _textController.text;
                                      prediction = _classifier.classify(text);

                                      SharedPref.setDailyProgress(prediction[1]);
                
                                      setState(() {

                                        journalText = _textController.text;

                                        _children.add(Dismissible(
                                          key: GlobalKey(),
                                          onDismissed: (direction) {},
                                          child: Card(
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              color: prediction[1] > prediction[0]
                                                  ? Colors.lightGreen
                                                  : Colors.redAccent,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "Input: $text",
                                                    style: const TextStyle(fontSize: 16),
                                                  ),
                                                  Text("Output:"),
                                                  Text("   Positive: ${prediction[1]}"),
                                                  Text("   Negative: ${prediction[0]}"),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ));
                                        _textController.clear();
                                      });
                                    },
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        );
                      }
                    );
                  }
                );
        
                }
        
                return const Text(
                  'loading!'
                );
        
              }
            );
          }
        ),
      ),
    );
  }
}