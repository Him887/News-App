import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/providers/article.dart';

class News with ChangeNotifier {
  List<Article> _items = [];

  List<Article> get items {
    return [..._items];
  }

  Article findByTitle(String title) {
    return [..._items].firstWhere((element) => element.title == title);
  }

  Future<void> fetchAndSetNews(String query) async {
    var url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$query&from=2021-11-11&sortBy=publishedAt&apiKey=13530d6dac10473e89f10b657cc37fe8");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Article> loadedNews = [];
      extractedData.forEach((key, value) {
        if (key == "articles") {
          value.forEach((article) {
            loadedNews.add(Article(
              author: article["author"] ?? "Anonymous",
              content: article["content"] ?? "",
              date: article["publishedAt"] ?? "",
              description: article["description"] ?? "",
              imageUrl: article["urlToImage"] ?? "https://images.theconversation.com/files/407039/original/file-20210617-15-2h4ak3.jpg?ixlib=rb-1.1.0&rect=0%2C10%2C3500%2C2321&q=45&auto=format&w=926&fit=clip",
              name: article["source"]["name"] ?? "",
              title: article["title"] ?? "",
              url: article["url"] ?? "",
            ));
          });
        }
      });
      _items = loadedNews;
      print(_items.length);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
