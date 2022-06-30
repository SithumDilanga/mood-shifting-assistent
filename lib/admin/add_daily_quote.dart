import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mood_shifting_assistent/services/database.dart';

class AddDailyQuote extends StatefulWidget {
  const AddDailyQuote({ Key? key }) : super(key: key);

  @override
  State<AddDailyQuote> createState() => _AddDailyQuoteState();
}

class _AddDailyQuoteState extends State<AddDailyQuote> {

  DatabaseService _databaseService = DatabaseService(uid: 'null');

  final itemNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF77BF87),
        title: const Text(
          'Add Daily Quote'
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded
          ),
          onPressed: () {
            Navigator.pop(context);
          }, 
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Text(
              'Daily Quote',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 16.0,),
            Expanded(
              child: Container(
                height: 55.0,
                child: TextFormField(
                  controller: itemNameController,
                  style: TextStyle(
                    fontSize: 16.0
                  ),
                  cursorColor: const Color(0xff77BF87),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff77BF87)),
                      borderRadius: BorderRadius.circular(2)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[500]!),
                      borderRadius: BorderRadius.circular(2)
                    )
                  ),
                ),
              ),
            ),
            Center(
              child: ElevatedButton( 
                child: const Text(
                  'Add Daily Quote', 
                  style: TextStyle(
                    fontSize: 16.0, 
                    color: Colors.white
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff77BF87),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                  ),
                  padding: const EdgeInsets.fromLTRB(66.0, 16.0, 66.0, 16.0),
                ),
                onPressed: () {

                  if(itemNameController.text.isNotEmpty) {

                    _databaseService.addNewDailyQuote(itemNameController.text)
                    .then((value) {
                      itemNameController.clear();
                    });
                  
                  } else {

                    Fluttertoast.showToast(
                      msg: "Please type the quote!",
                      toastLength: Toast.LENGTH_SHORT,
                    );

                  }


                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}