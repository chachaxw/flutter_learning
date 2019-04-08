import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

import 'services/api_service.dart';
import 'scrollable_tabs.dart';
import 'page.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learning',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Flutter Learning'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List newsData;
  bool loading = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final GlobalKey<_MyHomePageState> _myHomePageKey = GlobalKey<_MyHomePageState>();

  @override
  void initState() {
    super.initState();
    setState(() => loading = true);
    this.getNewsData();
  }

  Future<void> _handleRefresh() async {
    await this.getNewsData();
  }

  Future<void> getNewsData() async {
    var response = await ApiService().getNewsData();

    // To modify the state of the app, use this method
    setState(() {
      loading = false;
      // Get the JSON data
      var dataConvertedToJSON = json.decode(response.body);
      // Extract the required part and assign it to the global variable named data
      newsData = dataConvertedToJSON['articles'];
    });
  }

  Widget _buildLoading() {
    final Animation<Color> valueColor = new AlwaysStoppedAnimation<Color>(Colors.orange);

    return new Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(valueColor: valueColor),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('News Coming...'),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsList(BuildContext context, List<dynamic> data) {
    return new ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: newsData != null ? newsData.length : 0,
      itemBuilder: (BuildContext context, int index) {
        var item = data[index];
        var id = item['id'];
        var url = item['urlToImage'];
        var title = item['title'];
        var description = item['description'];

        return new Card(
          key: id,
          margin: const EdgeInsets.only(bottom: 16.0),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            leading: url != null ? Image.network(
              url,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ) : Icon(
              Icons.landscape,
              color: Colors.grey,
              size: 80.0,
            ),
            title: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              description,
              maxLines: 3,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }

  Widget _buildDiscover(BuildContext context, List<dynamic> newsData) {
    if (loading) {
      return _buildLoading();
    }

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _handleRefresh,
      color: Colors.orange,
      child: _buildNewsList(context, newsData),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableTabs(
      key: _myHomePageKey,
      title: 'News',
      initinalIndex: 1,
      pages: [
        Page(icon: Icons.favorite, text: 'Favorite', body: Text('Favorite')),
        Page(icon: Icons.explore, text: 'Discover', body: _buildDiscover(context, newsData)),
        Page(icon: Icons.grain, text: 'Hot', body: Text('Hot')),
      ],
    );
  }
}
