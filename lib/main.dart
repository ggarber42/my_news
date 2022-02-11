import 'package:flutter/material.dart';
import 'package:my_news/services/feed_service.dart';
import 'package:my_news/widgets/news_tile.dart';

import 'models/article_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My news',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'My news'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FeedService feed = FeedService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
          future: feed.fetchFeeds(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasData) {
              List<Article> articles = snapshot.data;
              return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) => NewsTile(articles[index]),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
