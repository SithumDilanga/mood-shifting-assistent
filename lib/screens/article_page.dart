// import 'dart:html';

import 'package:flutter/material.dart';

class ArticlePage extends StatefulWidget {

  final title;
  final description;
  final postImage;

  const ArticlePage({ Key? key, this.title, this.description, this.postImage }) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stay positive!',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          }, 
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                child: Text(
                  '${widget.title}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 16.0,),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  '${widget.postImage}',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${widget.description}',
                  style: const TextStyle(
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