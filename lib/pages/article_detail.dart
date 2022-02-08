import 'package:flutter/material.dart';
import 'package:my_news/models/article_model.dart';

class ArticleDetail extends StatelessWidget {
  final Article article;

  ArticleDetail(this.article);

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.description,
              style: const TextStyle(
                fontSize: 17,
              ),
            )
          ],
        ),
      ),
    );
  }
}
