import 'package:flutter/material.dart';
import 'package:my_news/models/article_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ArticleDetail extends StatelessWidget {
  final Article article;

  ArticleDetail(this.article);

  _goToArticle(){
    print(article.link);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.title,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Html(
              data: article.description,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigation),
        onPressed: () => _goToArticle(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}
