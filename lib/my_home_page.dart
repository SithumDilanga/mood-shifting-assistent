import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mood_shifting_assistent/admin/add_daily_quote.dart';
import 'package:mood_shifting_assistent/article_page.dart';
import 'package:mood_shifting_assistent/auth/sign_up.dart';
import 'package:mood_shifting_assistent/boost_yourself/boost_yourself.dart';
import 'package:mood_shifting_assistent/kavee_pages/registration_form.dart';
import 'package:mood_shifting_assistent/line_chart.dart';
import 'package:mood_shifting_assistent/models/uid.dart';
import 'package:mood_shifting_assistent/new_ui_pages/screens/home_page.dart';
import 'package:mood_shifting_assistent/previous_journals.dart';
import 'package:mood_shifting_assistent/services/auth.dart';
import 'package:mood_shifting_assistent/services/database.dart';
import 'package:mood_shifting_assistent/text_classification/text_classification.dart';
import 'package:provider/provider.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({Key? key,}) : super(key: key);

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {

  AuthService _authService = AuthService();
  DatabaseService _databaseService = DatabaseService(uid: 'null');

  Set<double> weeklyProgresses = {};

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UID>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood shifting'),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').doc(user.uid).collection('dailyProgress').orderBy('timeStamp', descending: false).limit(7).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
      
            if(streamSnapshot.hasData) {
      
              print('streamSnapshot ${streamSnapshot.data!.docs[0]['statusCalculation']}');
      
              for (dynamic element in streamSnapshot.data!.docs) {
                weeklyProgresses.add(element['statusCalculation']);
              }
      
              print('weeklyProgresses $weeklyProgresses');
      
            }
      
            return FutureBuilder(
              future: Future.wait([
                FirebaseFirestore.instance.collection('dailyQuote').orderBy('timeStamp', descending: true).limit(1).get() ,//_databaseService.getDailyQuote(),  
                _databaseService.getWeeklyProgresses(user.uid)
              ]), 
              builder: (BuildContext context, AsyncSnapshot snapshot) {
        
                if (snapshot.hasData) {
        
                  print('dailyQuote ${snapshot.data}');
        
                  dynamic weeklyProgresses = snapshot.data![0];
        
                  // Map<String, dynamic> snapshotData = weeklyProgresses as Map<String, dynamic>;
        
                  // print('new data ${snapshotData}');
        
                }
        
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        child: const Text(
                          'Text classification'
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TextClassification(
                              uid: user.uid,
                            )),
                          );
                        }, 
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Previous journals'
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PreviousJournals(uid: user.uid,)),
                          );
                        }, 
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Boost yourself'
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BoostYourself()),
                          );
                        }, 
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Line Chart'
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LineChart(
                              weeklyProgresses: weeklyProgresses
                            )),
                          );
                        }, 
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Sign up'
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        }, 
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Logout'
                        ),
                        onPressed: () {
            
                          _authService.logOut().whenComplete(() {
            
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
            
                          });
            
                        }, 
                      ),
                      ElevatedButton(
                        child: const Text(
                          'getDailyQuote'
                        ),
                        onPressed: () {
            
                          _databaseService.getDailyQuote();
            
                        }, 
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Add daily quote'
                        ),
                        onPressed: () {
                      
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddDailyQuote()
                              ),
                            );
                      
                        }, 
                      ),
                      ElevatedButton(
                        child: const Text(
                          'get weekly progresses'
                        ),
                        onPressed: () {
            
                          _databaseService.getWeeklyProgresses('Rfpm4kAiYKVwJcNNomVI');
            
                        }, 
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Article'
                        ),
                        onPressed: () {
                      
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ArticlePage()
                              ),
                            );
                      
                        }, 
                      ),
                      ElevatedButton(
                        child: const Text(
                          'New Home Page'
                        ),
                        onPressed: () {
                      
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage2(
                                  uid: user.uid,
                                )
                              ),
                            );
                      
                        }, 
                      ),
                    ],
                  ),
                );
              }
            );
          }
        ),
      ),
    );
  }
}
