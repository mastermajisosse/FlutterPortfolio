import 'dart:convert';

import 'package:web/Model/Article.dart';
import 'package:web/Services/Api.dart';

class ArticleService {
  static final ArticleService articleService = ArticleService._internal();
  ArticleService._internal();

  factory ArticleService() {
    return articleService;
  }

  Api api = Api();

  List<Article> lists;

  Future<List<Article>> getLists() async {
    lists = new List();
    // await api.httpGet('bins/fyqiq').then((reponse) {
    await api
        .httpGet('mastermajisosse/fotApp/master/justjson.json')
        .then((reponse) {
      var data = jsonDecode(reponse.body);
      data["news"].forEach((l) {
        lists.add(Article().fromJson(l));
      });
    });
    return lists;
  }
}
