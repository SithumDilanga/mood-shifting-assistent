import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mood_shifting_assistent/boost_yourself/boost_yourself.dart';
import 'package:mood_shifting_assistent/screens/line_chart.dart';
import 'package:mood_shifting_assistent/new_ui_pages/screens/previous_journals_screen.dart';
import 'package:mood_shifting_assistent/new_ui_pages/screens/settings.dart';
import 'package:mood_shifting_assistent/screens/today_feeling_type_screen.dart';
import 'package:mood_shifting_assistent/new_ui_pages/widgets/media_items_list.dart';
import 'package:mood_shifting_assistent/services/database.dart';
import 'package:mood_shifting_assistent/services/shared_pref.dart';
import 'package:mood_shifting_assistent/utils/loading_animation.dart';
import 'package:mood_shifting_assistent/utils/route_trans_anim.dart';
import 'package:provider/provider.dart';

import '../../models/uid.dart';

class HomePage2 extends StatefulWidget {

  // final String uid; required this.uid

  const HomePage2({Key? key, }) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {

  final DatabaseService _databaseService = DatabaseService(uid: 'null');
  Set<double> weeklyProgresses = {};

  String name = 'Sithum';
  String greetingMessage = 'Good day';

  Map<String, dynamic> snapshotData = {
    'statusCalculation': 0.5
  };

  Map<String, dynamic> dailyQuote = {
    'quote': 'Stay strong at life storms'
  };

  void init() async {
    if(SharedPref.getUserName() != null) {
      name = (await SharedPref.getUserName())!;
    }
  }

  String greeting() {
    var hour = DateTime.now().hour;
    
    if(hour < 12) {
      return 'Good morning';
    }

    if(hour < 17) {
      return 'Good afternoon';
    }

    return 'Good evening';

  }

  @override
  void initState() {

    init();
    greetingMessage = greeting();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UID?>(context);

        return FutureBuilder(
          future: Future.wait([
            _databaseService.getDailyProgress(user!.uid),
            _databaseService.getDailyQuote(),
          ]),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    
            if (snapshot.connectionState == ConnectionState.done) {

              if(snapshot.data != null) {

                snapshotData = snapshot.data[0].data() as Map<String, dynamic>;

                dailyQuote = snapshot.data[1].data() as Map<String, dynamic>;

              }
        
              double dailyProgress = snapshotData['statusCalculation'];
              // dynamic dailyQuote = dailyQuoteData['quote'];
    
              return StreamBuilder<QuerySnapshot>(
                stream: _databaseService.getPosts(user.uid, dailyProgress),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
    
                  if(snapshot.connectionState == ConnectionState.done) {
        
                    // print('streamSnapshot2 ${streamSnapshot.data!.docs[0]['title']}');
    
                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('users').doc(user.uid).collection('dailyProgress').orderBy('timeStamp', descending: false).limit(7).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> weeklyStreamSnapshot) {

                        if(snapshot.connectionState == ConnectionState.done) {

                          if(weeklyStreamSnapshot.data != null) {
                            for (dynamic element in weeklyStreamSnapshot.data!.docs) {
                              weeklyProgresses.add(element['statusCalculation']);
                            }
                          }

                          return Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/app-background.jpg"), 
                                fit: BoxFit.cover,
                                // colorFilter: ColorFilter.mode(
                                //       Colors.white.withOpacity(0.9), BlendMode.dstATop
                                //   ),
                                ),
                            ),
                            child: Scaffold(
                              backgroundColor: Colors.transparent,
                              body: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Container(
                                      //   //for safe area
                                      //   height: 20,
                                      // ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.settings
                                          ),
                                          onPressed: () {
                                            
                                            Navigator.of(context).push(
                                              RouteTransAnim().createRoute(
                                                1.0, 0.0, 
                                                SettingsPage()
                                              )
                                            );

                                          }, 
                                        ),
                                      ),                                    
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20, right: 30),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${greetingMessage}",
                                              style: textStyleForGreeting,
                                            ),
                                            Text(
                                              "${name}", 
                                              style: textStyleForUserName
                                            ),
                                          ],
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
                                          // height: 45,
                                          // width: MediaQuery.of(context).size.width - 40,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                '${dailyQuote['quote']}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        child: LabelType1(
                                          text: "How do you feel today",
                                          uid: user.uid,
                                        ),
                                        onTap: () {

                                          Navigator.of(context).push(
                                            RouteTransAnim().createRoute(
                                              1.0, 0.0, 
                                              TodayFeelingScreen2(
                                                uid: user.uid,
                                              )
                                            )
                                          );

                                        },
                                      ),
                                      GestureDetector(
                                        child: LabelType1(
                                          text: "Previous journals",
                                          uid: user.uid,
                                        ),
                                        onTap: () {

                                          Navigator.of(context).push(
                                            RouteTransAnim().createRoute(
                                              1.0, 0.0, 
                                              PreviousJournals2(uid: user.uid,)
                                            )
                                          );

                                        },
                                      ),
                                      GestureDetector(
                                        child: LabelType1(
                                          text: "Your weekly mood",
                                          uid: user.uid,
                                        ),
                                        onTap: () {

                                          Navigator.of(context).push(
                                            RouteTransAnim().createRoute(
                                              1.0, 0.0, 
                                              LineChart(
                                                weeklyProgresses: weeklyProgresses,
                                              )
                                            )
                                          );

                                        },
                                      ),
                                      GestureDetector(
                                        child: LabelType1(
                                          text: "Boost yourself",
                                          uid: user.uid,
                                        ),
                                        onTap: () {

                                          Navigator.of(context).push(
                                            RouteTransAnim().createRoute(
                                              1.0, 0.0, 
                                              BoostYourself()
                                            )
                                          );

                                        },
                                      ),
                                      const SizedBox(height: 8.0,),
                                      const Text(
                                        "For you",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      const SizedBox(height: 8.0,),
                                      if(streamSnapshot.data != null)
                                        MediaItemList2(
                                          articleList: streamSnapshot.data?.docs,
                                        ),
                                    ],
                                  ),
                                ),
                              )),
                          );

                        }

                        return const LoadingAnimation();

                      }
                    );
    
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
    required this.text, 
    this.uid,
  }) : super(key: key);

  final String text;
  final uid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        borderRadius: BorderRadius.circular(6),
        elevation: 4,
        child: Container(
          // height: 45,
          decoration: BoxDecoration(
            color: Color(0xFF77BF87),
            //color: Colors.teal,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 4.0
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text, 
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    )
                  )
                ),
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
    );
  }
}
