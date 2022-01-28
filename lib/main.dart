import 'package:flutter/material.dart';
import 'package:my_news/services/feed_service.dart';

import 'models/article_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My (anti)news',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'My (anti)news'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  FeedService feed = FeedService();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    feed.fetchFeed();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
          future: feed.fetchFeed(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasData) {
              //Now let's make a list of articles
              List<Article>? articles = snapshot.data;
              return ListView.builder(
                //Now let's create our custom List tile
                itemCount: articles!.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(articles[index].title),
                  leading: Image.network(articles[index].imgUrl)
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
