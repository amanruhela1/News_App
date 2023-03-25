import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsRepository {
  Future<List<ArticleModel>> fetchNews() async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=tesla&from=2023-02-25&sortBy=publishedAt&apiKey=62b32814955c4f37a352606a5434ee3e"));

    var data = jsonDecode(response.body);

    List<ArticleModel> _articleModelList = [];

    if (response.statusCode == 200) {
      for (var item in data["articles"]) {
        ArticleModel _artcileModel = ArticleModel.fromJson(item);
        _articleModelList.add(_artcileModel);
      }
      return _articleModelList;
    } else {
      return _articleModelList;
    }
  }
}