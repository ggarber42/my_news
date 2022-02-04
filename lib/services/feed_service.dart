import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'package:intl/intl.dart';

import 'package:my_news/utils.dart';
import '../models/article_model.dart';

class FeedService {
  // final feedUrl = 'https://actualidad.rt.com/feeds/all.rss';
  final feedUrl = 'https://jacobin.com.br/feed';

  Future<List<Article>> fetchFeed() async {
    final client = http.Client();
    final res = await client.get(Uri.parse(feedUrl));
    if (res.statusCode == 200) {
      var rssFeed = RssFeed.parse(res.body);
      List<Article> articles = [];
      for (int index = 0; index < rssFeed.items!.length; index++) {
        // inspect(rssFeed.items?[index]);
        var title = Utils.sanatizeValue(rssFeed.items![index].title.toString());
        if (title == '') {
          continue;
        }
        var description =
            Utils.sanatizeValue(rssFeed.items![index].description.toString());
        var imgUrl = Utils.sanatizeValue(
            rssFeed.items![index].enclosure?.url.toString());
        var formatedDate =
            DateFormat.yMd().format(rssFeed.items![index].pubDate as DateTime);
        var pubDate = formatedDate.toString();
        var link =
            Utils.sanatizeValue(rssFeed.items![index].description.toString());
        articles.add(new Article(title, description, link, pubDate, imgUrl));
      }
      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}
