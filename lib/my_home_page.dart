import 'package:flutter/material.dart';
import 'package:mood_shifting_assistent/boost_yourself/boost_yourself.dart';
import 'package:mood_shifting_assistent/text_classification/text_classification.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
            )
          ],
        ),
      ),
    );
  }
}
