import 'package:flutter/material.dart';
import 'package:mood_shifting_assistent/auth/sign_up.dart';
import 'package:mood_shifting_assistent/boost_yourself/boost_yourself.dart';
import 'package:mood_shifting_assistent/line_chart.dart';
import 'package:mood_shifting_assistent/services/auth.dart';
import 'package:mood_shifting_assistent/text_classification/text_classification.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
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
                  MaterialPageRoute(builder: (context) => const TextClassification()),
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
                  MaterialPageRoute(builder: (context) => LineChart()),
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
            )
          ],
        ),
      ),
    );
  }
}
