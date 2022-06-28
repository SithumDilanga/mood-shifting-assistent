import 'package:flutter/material.dart';

class PreviousJournals2 extends StatelessWidget {
  const PreviousJournals2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                      onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                ),
                const Text(
                  'Previous Journals',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 100,
            child: ListView(
              children: const [JournalItem()],
            ),
          ),
        ],
      ),
    );
  }
}

class JournalItem extends StatelessWidget {
  const JournalItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 8),
            child: Text('2022.06.02'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFF77BF87),
                    borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Lorem ipsum dolor sit amet, cons adipiscing elit. Vestibulum blandit ultrices',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
