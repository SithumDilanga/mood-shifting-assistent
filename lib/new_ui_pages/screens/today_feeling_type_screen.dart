// ignore_for_file: deprecated_member_use, unnecessary_new

import 'package:flutter/material.dart';
import 'package:mood_shifting_assistent/services/database.dart';
import 'package:mood_shifting_assistent/services/shared_pref.dart';
import 'package:mood_shifting_assistent/text_classification/classifier.dart';

class TodayFeelingScreen2 extends StatefulWidget {

  final String uid;

  const TodayFeelingScreen2({Key? key, required this.uid}) : super(key: key);

  @override
  State<TodayFeelingScreen2> createState() => _TodayFeeling2ScreenState();
}

class _TodayFeeling2ScreenState extends State<TodayFeelingScreen2> {

  late TextEditingController _textController;
  late Classifier _classifier;
  String journalText = '';
  dynamic prediction;

  final DatabaseService _databaseService = DatabaseService(uid: 'null');

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _classifier = Classifier();

    // init();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child:
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
          ),
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Text(
              'How do you feel today?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              cursorColor: const Color(0xFF77BF87),
              maxLines: 50,
              minLines: 1,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  //labelText: 'Enter Name',
                  hintText: 'Type here...'),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 8.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0xFF77BF87),
                child: const Text("Save"),
                onPressed: () {

                  final text = _textController.text;
                  prediction = _classifier.classify(text);

                  SharedPref.setDailyProgress(prediction[1]);

                  _databaseService.sendDailyProgress(
                    widget.uid,
                    _textController.text,
                    prediction[1]
                  ).whenComplete(() {

                    _textController.clear();

                  });
                
                  // setState(() {

                  //   journalText = _textController.text;
                  //   _textController.clear();
                  // });

                },
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
