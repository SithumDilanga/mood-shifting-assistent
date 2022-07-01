// ignore_for_file: deprecated_member_use, unnecessary_new

import 'package:flutter/material.dart';
import 'package:mood_shifting_assistent/article_page.dart';
import 'package:mood_shifting_assistent/utils/route_trans_anim.dart';

class MediaItemList2 extends StatelessWidget {

  final dynamic articleList;

  const MediaItemList2({
    Key? key, this.articleList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      // padding: const EdgeInsets.all(8.0),
      itemExtent: 160.0,
      itemCount: articleList?.length,
      itemBuilder: (context, index) {
        return CustomListItem(
          thumbnail: Container(
            height: 150,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(9),
                  bottomLeft: Radius.circular(9)),
              child: Image(
                  image: NetworkImage(
                    '${articleList[index]['postImage']}'
                  ), fit: BoxFit.cover),
            ),
          ),
          title: '${articleList[index]['title']}',
          description: '${articleList[index]['description']}',
          postImgLink: '${articleList[index]['postImage']}',
        );
      }
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.description, 
    required this.postImgLink,
  }) : super(key: key);

  final Widget thumbnail;
  final String postImgLink;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFF77BF87))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: thumbnail,
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
                        child: Text(
                          title, 
                          style: _TitleTextStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
                        child: Text(
                          description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.only(bottom: 4, left: 4, right: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:const EdgeInsets.only(left: 12.0, right: 12.0),
                                child: RaisedButton(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0
                                  ),
                                  textColor: Colors.white70,
                                  color: const Color(0xFF77BF87),
                                  child: const Text(
                                    "Read more",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      RouteTransAnim().createRoute(
                                        1.0, 0.0, 
                                        ArticlePage(
                                          title: title,
                                          description: description,
                                          postImage: postImgLink,
                                        )
                                      )
                                    );
                                  },
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
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
    fontSize: 18
  );
}
