import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:flutter_learning/routes.dart';

class NewsDetailPage extends StatefulWidget {
  NewsDetailPage({
    @required this.url,
    @required this.title,
    @required this.source,
    @required this.content,
    @required this.urlToImage,
    @required this.publishedAt
  }) : super(key: AppRouteKeys.newsNetailPage);

  final String url;
  final String title;
  final String source;
  final String content;
  final String urlToImage;
  final String publishedAt;

  @override
  State<StatefulWidget> createState() => NewsDetailState(
    url: url,
    title: title,
    source: source,
    content: content,
    urlToImage: urlToImage,
    publishedAt: publishedAt
  );
}

class NewsDetailState extends State<NewsDetailPage> {
  NewsDetailState({
    this.url,
    this.title,
    this.source,
    this.content,
    this.urlToImage,
    this.publishedAt
  });

  final String url;
  final String title;
  final String source;
  final String content;
  final String urlToImage;
  final String publishedAt;

  final double _appBarHeight = 256.0;
  static final GlobalKey<ScaffoldState> _newsDetailKey = GlobalKey<ScaffoldState>();

  Widget _buildStack(BuildContext context, String urlToImage) {
    print(urlToImage);
    var backgroundImage = Image(
      fit: BoxFit.cover,
      image: new NetworkImageWithRetry(urlToImage),
    );

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: <Widget>[
        backgroundImage,
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.0, 0.8),
              end: Alignment(0.0, -1.0),
              colors: <Color>[Color(0x80000000), Color(0x00000000)],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      key: _newsDetailKey,
      data: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.indigo),
        backgroundColor: Colors.white,
      ),
      child: Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: _appBarHeight,
              pinned: true,
              floating: false,
              snap: false,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.favorite),
                  tooltip: 'Love',
                  onPressed: () {
                   print("Love this");
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.bookmark),
                  tooltip: 'Bookmark',
                  onPressed: () {
                   print("Bookmark");
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  tooltip: 'Share',
                  onPressed: () {
                   print("Share");
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: EdgeInsets.only(left: 40.0, bottom: 16.0),
                title: Text(
                  'From: $source',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                background: _buildStack(context, urlToImage),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      title ?? '',
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      content ?? '',
                      style: Theme.of(context).textTheme.display1
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      )
    );
  }
}