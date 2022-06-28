import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mood_shifting_assistent/models/list_tile_model.dart';
import 'package:mood_shifting_assistent/new_ui_pages/screens/previous_journals_screen.dart';
import 'package:mood_shifting_assistent/new_ui_pages/screens/today_feeling_type_screen.dart';
import 'package:mood_shifting_assistent/new_ui_pages/widgets/media_items_list.dart';
import 'package:mood_shifting_assistent/services/database.dart';
import 'package:mood_shifting_assistent/utils/loading_animation.dart';
import 'package:mood_shifting_assistent/widgets/media_items_list.dart';

class HomePage2 extends StatefulWidget {

  final String uid;

  const HomePage2({Key? key, required this.uid}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {

  final DatabaseService _databaseService = DatabaseService(uid: 'null');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _databaseService.getDailyProgress(widget.uid),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

        if (snapshot.hasData) {

          Map<String, dynamic> snapshotData = snapshot.data!.data() as Map<String, dynamic>;

          double dailyProgress = snapshotData['statusCalculation'];
        
          print('newbitch ${dailyProgress}');


          return StreamBuilder<QuerySnapshot>(
            stream: _databaseService.getPosts(widget.uid, dailyProgress),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {

              if(streamSnapshot.hasData) {
    
                print('streamSnapshot2 ${streamSnapshot.data!.docs[0]['title']}');


                return Scaffold(
                backgroundColor: Color(0xFFd5e5d8),
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                      child: Container(
                        height: 280,
                        //color: Colors.amber,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              //for safe area
                              height: 20,
                            ),
              
                            // ignore: avoid_unnecessary_containers
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 30),
                              child: Container(
                                width: 300,
                                // color: Colors.red,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Good Morning",
                                      style: textStyleForGreeting,
                                    ),
                                    Text("SDLive", style: textStyleForUserName),
                                  ],
                                ),
                              ),
                            ),
              
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  //color: Colors.lightGreen,
                                  border: Border.all(
                                    color: Color(0xFF77BF87),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: 45,
                                width: MediaQuery.of(context).size.width - 40,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text("Stay strong at life stroms",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            LabelType1(
                              text: "How do you feel today",
                              textStyleForQoute: textStyleForQoute,
                              uid: widget.uid,
                            ),
              
                            LabelType1(
                              text: "Previous journals",
                              textStyleForQoute: textStyleForQoute,
                              uid: widget.uid,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(
                                "For you",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //////////////////////////////////////////////////////////////////
              
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height - 310,
                        child: MediaItemList2(
                          articleList: streamSnapshot.data!.docs,
                        ),
                      ),
                    )
                  ],
                ));

              }

              return const LoadingAnimation();

            }
          );

        }

        return const LoadingAnimation();

      }
    );
  }

  var textStyleForGreeting = const TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );

  var textStyleForUserName = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black54);

  var textStyleForQoute = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white70);
}

class LabelType1 extends StatelessWidget {
  const LabelType1({
    Key? key,
    required this.textStyleForQoute,
    required this.text, 
    this.uid,
  }) : super(key: key);

  final TextStyle textStyleForQoute;
  final String text;
  final uid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        child: Material(
          borderRadius: BorderRadius.circular(6),
          elevation: 6,
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: Color(0xFF77BF87),
              //color: Colors.teal,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: Text(text, style: textStyleForQoute)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 18,
                        color: Colors.white70,
                      ))
                ],
              ),
            ),
          ),
        ),
        onTap: () {

          if(text == 'Previous journals') {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PreviousJournals2()),
            );

          } else if(text == 'How do you feel today') {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TodayFeelingScreen2(
                uid: uid,
              )),
            );

          }

        },
      ),
    );
  }
}
