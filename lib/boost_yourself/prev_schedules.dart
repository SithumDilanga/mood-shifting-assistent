// import 'dart:html';

import 'package:flutter/material.dart';

class PreviousSchedules extends StatefulWidget {

  final List<String>? quoteList;
  final List<String>? dateTimeList;

  const PreviousSchedules({Key? key, this.quoteList, this.dateTimeList}) : super(key: key);

  @override
  _PreviousSchedulesState createState() => _PreviousSchedulesState();
}

class _PreviousSchedulesState extends State<PreviousSchedules> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              if(widget.dateTimeList!.isEmpty)
                Card(
                  color: const Color(0xFF77BF87),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'No Schedules Yet!',
                      style: TextStyle(
                        color: Colors.white,                      
                      ),
                    ),
                  )
                ),

              if(widget.dateTimeList!.length >= 1)
                CardView(
                  date_time: widget.dateTimeList![widget.dateTimeList!.length - 1], 
                  quote: widget.quoteList![widget.quoteList!.length - 1] ,
                ),
              if(widget.dateTimeList!.length >= 2)
                CardView(
                  date_time: widget.dateTimeList![widget.dateTimeList!.length - 2], 
                  quote:widget.quoteList![widget.quoteList!.length - 2],
                )
            ],
          ),
        ),
      ),
    );
  }
}

class CardView extends StatelessWidget {

  final String? date_time;
  final String? quote; 

  CardView({this.date_time, this.quote});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF77BF87),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget> [
            Text(
              date_time!,
              style: TextStyle(
                fontSize: 11,
                color: Colors.white, 
              )
            ),
            SizedBox(height: 4.0),
            Text(
              quote!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white, 
              )
            )
          ],
        ),
      ),
    );
  }
}