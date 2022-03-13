import 'package:flutter/material.dart';
import 'package:mood_shifting_assistent/models/list_tile_model.dart';
import 'package:mood_shifting_assistent/widgets/media_items_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: Container(
            height: 272,
            //color: Colors.amber,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //for safe area
                  height: 20,
                ),

                // ignore: avoid_unnecessary_containers
                Container(
                  width: 300,
                  // color: Colors.red,
                  child: Column(
                    children: [
                      Text(
                        "Good Morning",
                        style: textStyleForGreeting,
                      ),
                      Text("SDLive", style: textStyleForUserName),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    height: 45,
                    width: MediaQuery.of(context).size.width - 40,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text("Stay strong at life stroms",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                fontStyle: FontStyle.italic)),
                      ),
                    ),
                  ),
                ),
                LabelType1(
                    text: "How do you feel today",
                    textStyleForQoute: textStyleForQoute),

                LabelType1(
                    text: "Previous journals",
                    textStyleForQoute: textStyleForQoute),
                const Text(
                  "For you",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        //////////////////////////////////////////////////////////////////

        SizedBox(
          height: MediaQuery.of(context).size.height - 300,
          child: const MediaItemList(),
        )
      ],
    ));
  }

  var textStyleForGreeting = const TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  );
  var textStyleForUserName = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.w500, color: Colors.teal);
  var textStyleForQoute = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black54);
}

class LabelType1 extends StatelessWidget {
  const LabelType1({
    Key? key,
    required this.textStyleForQoute,
    required this.text,
  }) : super(key: key);

  final TextStyle textStyleForQoute;
  final String text;

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
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.teal,
                ],
              ),
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
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
