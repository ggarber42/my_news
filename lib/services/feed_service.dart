import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'package:intl/intl.dart';

import 'package:my_news/utils.dart';
import '../models/article_model.dart';

class FeedService {
  final feedsUrl = [
    'https://nexojornal.com.br/rss.xml',
    'http://rss.dw.com/rdf/rss-br-all',
    'https://www.cartoonbrew.com/feed'
  ];

  Future<List<Article>> fetchFeeds() async {
    List<Article> articles = [];
    for (int index = 0; index < feedsUrl.length; index++) {
      var fetchedArticles = await fetchFeed(feedsUrl[index]);
      articles = [...articles, ...fetchedArticles];
    }
    return articles;
  }

  Future<List<Article>> fetchFeed(feedUrl) async {
    final client = http.Client();
    final res = await client.get(Uri.parse(feedUrl));
    if (res.statusCode == 200) {
      var rssFeed = RssFeed.parse(res.body);
      List<Article> articles = [];
      for (int index = 0; index < rssFeed.items.length; index++) {
        inspect(rssFeed.items[index]);
        var title = Utils.sanatizeValue(rssFeed.items[index].title.toString());
        if (title == '') {
          continue;
        }
        var description =
            Utils.sanatizeValue(rssFeed.items[index].description.toString());
        String formatedDate;
        String pubDate;
        if (rssFeed.items[index].pubDate != null) {
          formatedDate = DateFormat.yMd().format(rssFeed.items[index].pubDate as DateTime);
          pubDate = formatedDate.toString();
        } else {
          pubDate = '??/??/??';
        }
        var link =
            Utils.sanatizeValue(rssFeed.items[index].link.toString());
        articles.add(new Article(title, description, link, pubDate));
      inspect(link);
      }
      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}
