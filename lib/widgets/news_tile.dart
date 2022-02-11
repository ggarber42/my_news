import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:my_news/models/article_model.dart';
import 'package:my_news/pages/article_detail.dart';

class NewsTile extends StatelessWidget {
  final Article article;

  NewsTile(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration:
          BoxDecoration(border: Border.all(width: .5, color: Colors.grey)),
      child: ListTile(
        leading: Image.asset(
                'assets/images/placeholder.jpg',
                fit: BoxFit.cover,
              ),
        title: Text(article.title,
            style: TextStyle(
              fontSize: 17.5,
            )),
        subtitle: Text(article.pubDate),
        trailing: Icon(Icons.more_vert),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetail(article),
            ),
          );
        },
      ),
    );
  }
}
