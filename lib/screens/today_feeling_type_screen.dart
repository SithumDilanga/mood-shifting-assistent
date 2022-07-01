// ignore_for_file: deprecated_member_use, unnecessary_new

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mood_shifting_assistent/screens/home_page.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                }, 
                icon: const Icon(
                  Icons.arrow_back_ios
                )
              ),
              const SizedBox(
                height: 64,
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
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                child: TextField(
                  controller: _textController,
                  cursorColor: const Color(0xFF77BF87),
                  maxLines: 50,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)
                    ),
                      //labelText: 'Enter Name',
                    hintText: 'Type here...',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color(0xFF77BF87)),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color(0xFF77BF87)),
                      borderRadius: BorderRadius.circular(8)
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 8.0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: const Color(0xFF77BF87),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(48.0, 12.0, 48.0, 12.0),
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    ),
                    onPressed: () {

                      if(_textController.text.isNotEmpty) {

                        final text = _textController.text;
                        prediction = _classifier.classify(text);

                        SharedPref.setDailyProgress(prediction[1]);

                        _databaseService.sendDailyProgress(
                          widget.uid,
                          _textController.text,
                          prediction[1]
                        ).whenComplete(() {
                        
                          _textController.clear();
                          
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage2()),
                            (Route<dynamic> route) => false,
                          );

                        });

                      } else {

                        Fluttertoast.showToast(
                          msg: "Please type how you feel today",
                          toastLength: Toast.LENGTH_SHORT,
                        );

                      }
      
                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              )
            ],
          ),
        ),
      ),
    );
  }
}
