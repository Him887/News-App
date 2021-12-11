import 'package:flutter/material.dart';
import 'package:news/providers/news.dart';
import 'package:news/widgets/news_item.dart';
import 'package:provider/provider.dart';

class NewsGrid extends StatelessWidget {
  const NewsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsData = Provider.of<News>(context);
    final news = newsData.items;
    return ListView.builder(
        itemCount: news.length,
        itemBuilder: (ctx, i) {
          return NewsItem(
            index: i,
          );
        });
  }
}
