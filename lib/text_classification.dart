import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mood_shifting_assistent/classifier.dart';
import 'package:mood_shifting_assistent/services/database.dart';

class TextClassification extends StatefulWidget {
  const TextClassification({ Key? key }) : super(key: key);

  @override
  _TextClassificationState createState() => _TextClassificationState();
}

class _TextClassificationState extends State<TextClassification> {

  late TextEditingController _controller;
  late Classifier _classifier;
  late List<Widget> _children;

  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _classifier = Classifier();
    _children = [];
    _children.add(Container());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child : Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: const Text('Text classification'),
        ),
        body: FutureBuilder(
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

                      _databaseService.sendDailyProgress('Rfpm4kAiYKVwJcNNomVI');
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

                      _databaseService.getWeekFromDailyProgress('Rfpm4kAiYKVwJcNNomVI');

                    }, 
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orangeAccent)),
                    child: Row(children: <Widget>[
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: 'Write some text here'),
                          controller: _controller,
                        ),
                      ),
                      TextButton(
                        child: const Text('Classify'),
                        onPressed: () {
                          
                          final text = _controller.text;
                          final prediction = _classifier.classify(text);

                          setState(() {
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
                            _controller.clear();
                          });
                        },
                      ),
                    ]),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}