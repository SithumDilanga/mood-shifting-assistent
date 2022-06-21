import 'package:flutter/material.dart';

class TodayFeelingScreen extends StatefulWidget {
  const TodayFeelingScreen({Key? key}) : super(key: key);

  @override
  State<TodayFeelingScreen> createState() => _TodayFeelingScreenState();
}

class _TodayFeelingScreenState extends State<TodayFeelingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          const Text(
            'How do you feel today?',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  //labelText: 'Enter Name',
                  hintText: 'Type here'),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          PhysicalModel(
            elevation: 6,
            shadowColor: Colors.black,
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
