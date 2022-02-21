import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/config/Resource.dart';
import 'package:news_app/models/News.dart';

class NewsProvider extends ChangeNotifier {
  List<News> newsList =
      []; /*List.generate(
      5,
      (index) => News(
          title: "Test",
          description: "Desc",
          image: "",
          postUrl: "ds")).toList();*/

  String getBaseUrl(String topic) {
    return "https://newsapi.org/v2/top-headlines?country=us&category=${topic.toLowerCase()}&apiKey=${Resource.API_KEY}";
  }

  Future<dynamic> getNews(String topicName) async {
    try {
      var dio = Dio();
      Response response = await dio.get(getBaseUrl(topicName));

      await Future.delayed(const Duration(seconds: 2));
      if (response != null) {
        Map<String, dynamic> map = response.data;
        List<dynamic> articleData = map["articles"];
        print("Response Okay " + articleData.length.toString());
        newsList.clear();
        articleData.forEach((element) {
          if (element['description'] != null && element['urlToImage'] != null) {
            String title = element['title'];
            String description = element['description'];

            String image = element['urlToImage'];
            String postUrl = element['url'];
            newsList.add(News(
                title: title,
                description: description,
                image: image,
                postUrl: postUrl));
          }
        });
      } else {
        print("Response Null");
      }
    } catch (exception) {
      print(exception);
    }
  }
}
