import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/news_model.dart';

class ApiHelper {
  static const String _baseUrl = "https://newsapi.org/v2/top-headlines";
  static const String _apiKey = "ac248671fecf4e9597aa759f2898bc7e";

  Future<NewsModel> fetchTopHeadlines({String country = "us", String category = "business"}) async {
    final uri = Uri.parse("$_baseUrl?country=$country&category=$category&apiKey=$_apiKey");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return NewsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../model/news_model.dart';
//
// class ApiHelper {
//   static const String _baseUrl = "https://newsapi.org/v2/everything";
//   static const String _apiKey = "ac248671fecf4e9597aa759f2898bc7e";
//
//   Future<NewsModel> fetchNews() async {
//     final uri = Uri.parse("$_baseUrl?q=tesla&from=2024-11-10&sortBy=publishedAt&apiKey=$_apiKey");
//     final response = await http.get(uri);
//
//     if (response.statusCode == 200) {
//       return NewsModel.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load news');
//     }
//   }
// }
//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ac248671fecf4e9597aa759f2898bc7e