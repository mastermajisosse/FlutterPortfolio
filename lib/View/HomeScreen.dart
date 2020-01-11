import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/Helper.dart';
import 'package:web/Model/Article.dart';
import 'package:web/Services/ArticleServices.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Article> _articles = [];
  ArticleService articleService;
  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  _fetchArticles() async {
    articleService = ArticleService();
    await articleService.getLists().then((data) {
      setState(() {
        _articles = data;
      });
    });
  }

  _buildArticlesGrid(MediaQueryData mediaQuery) {
    List<GridTile> tiles = [];
    _articles.forEach((article) {
      tiles.add(_buildArticleTile(article, mediaQuery));
    });
    return Padding(
      padding: responsivePadding(mediaQuery),
      child: GridView.count(
        crossAxisCount: responsiveNumGridTiles(mediaQuery),
        mainAxisSpacing: 30.0,
        crossAxisSpacing: 30.0,
        shrinkWrap: true,
        children: tiles,
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _buildArticleTile(Article article, MediaQueryData mediaQuery) {
    return GridTile(
      child: GestureDetector(
        onTap: () => _launchURL(
            'https://s.ftcdn.net/v2013/pics/all/curated/RKyaEDwp8J7JKeZWQPuOVWvkUjGQfpCx_cover_580.jpg?r=1a0fc22192d0c808b8bb2b9bcfbf4a45b1793687'),
        child: Column(
          children: <Widget>[
            Container(
              height: responsiveImageHeight(mediaQuery),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(article.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.center,
              height: responsiveTitleHeight(mediaQuery),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 1),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Text(
                article.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(height: 80.0),
          Center(
            child: Text('Portfolio Otmane El majid',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                )),
          ),
          SizedBox(height: 15.0),
          _articles.length > 0
              ? _buildArticlesGrid(mediaQuery)
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }
}
