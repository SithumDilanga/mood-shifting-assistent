// import 'dart:html';

import 'package:flutter/material.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({ Key? key }) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'sd'
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0,),
              const Padding(
                padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                child: Text(
                  'How to keep your motivation straight',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 16.0,),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  'https://www.jpf-film.org.uk/wp-content/uploads/112_14_00794-700x450.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0,),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sodales lectus non ornare sagittis. Nunc a est risus. Fusce et odio erat. Donec varius massa quis aliquet rutrum. Duis quis placerat magna. Quisque diam felis, ultricies in ligula a, tincidunt suscipit orci. Aliquam at sem eget orci euismod rhoncus. Sed sem mauris, vestibulum eget molestie quis, porta ut mi. Quisque eget arcu vitae odio cursus mattis. Cras ultricies, massa vel elementum ultrices, eros mi pretium augue, nec aliquet massa lacus et sapien. Aenean purus felis, tincidunt id venenatis ut, tempus a orci. Pellentesque bibendum vel felis et varius. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sodales lectus non ornare sagittis. Nunc a est risus. Fusce et odio erat. Donec varius massa quis aliquet rutrum. Duis quis placerat magna. Quisque diam felis, ultricies in ligula a, tincidunt suscipit orci. Aliquam at sem eget orci euismod rhoncus. Sed sem mauris, vestibulum eget molestie quis, porta ut mi. Quisque eget arcu vitae odio cursus mattis. Cras ultricies, massa vel elementum ultrices, eros mi pretium augue, nec aliquet massa lacus et sapien. Aenean purus felis, tincidunt id venenatis ut, tempus a orci. Pellentesque bibendum vel felis et varius. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sodales lectus non ornare sagittis. Nunc a est risus. Fusce et odio erat. Donec varius massa quis aliquet rutrum. Duis quis placerat magna. Quisque diam felis, ultricies in ligula a, tincidunt suscipit orci. Aliquam at sem eget orci euismod rhoncus. Sed sem mauris, vestibulum eget molestie quis, porta ut mi. Quisque eget arcu vitae odio cursus mattis. Cras ultricies, massa vel elementum ultrices, eros mi pretium augue, nec aliquet massa lacus et sapien. Aenean purus felis, tincidunt id venenatis ut, tempus a orci. Pellentesque bibendum vel felis et varius. ',
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}