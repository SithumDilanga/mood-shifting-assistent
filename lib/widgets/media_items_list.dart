import 'package:flutter/material.dart';

class MediaItemList extends StatelessWidget {
  const MediaItemList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      itemExtent: 140.0,
      children: <CustomListItem>[
        CustomListItem(
            thumbnail: Container(
              height: 130,
              child: const Image(
                  image: AssetImage('assets/car1.jpg'), fit: BoxFit.cover),
              decoration: const BoxDecoration(color: Colors.blue),
            ),
            title: 'The Flutter YouTube Channel',
            description:
                'This is a text description one for mood shifting app. Testing sentance'),
        CustomListItem(
            thumbnail: Container(
              height: 130,
              child: const Image(
                  image: AssetImage('assets/car2.jpg'), fit: BoxFit.cover),
              decoration: const BoxDecoration(color: Colors.yellow),
            ),
            title: 'Announcing Flutter 1.0',
            description:
                'This is a text description one for mood shifting app. Testing sentance'),
      ],
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.description,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            //color: Colors.orange,
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.amberAccent,
                Colors.amber,
                Colors.orange,
                Colors.orangeAccent,
              ],
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: thumbnail,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
                      child: Text(title, style: _TitleTextStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
                      child: Text(
                        description,
                      ),
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.only(bottom: 6, left: 6, right: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              child: PhysicalModel(
                                elevation: 6,
                                shadowColor: Colors.black,
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: 81,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Read more',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final _TitleTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
  );
}
