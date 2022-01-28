import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

import '../models/article_model.dart';

class FeedService {
  final feedUrl = 'https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss';

  Future<List<Article>> fetchFeed() async {
    final client = http.Client();
    final res = await client.get(Uri.parse(feedUrl));
    if (res.statusCode == 200) {
      var rssFeed = RssFeed.parse(res.body);
      List<Article> articles = [];
      for (int index = 0; index < rssFeed.items!.length; index++) {
        // inspect(rssFeed.items![index]);
        articles.add(new Article(
          rssFeed.items![index].title as String,
          rssFeed.items![index].description as String,
          rssFeed.items![index].enclosure!.url as String
        ));
      }
      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}
