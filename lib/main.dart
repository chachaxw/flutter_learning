import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'dart:convert';
import 'dart:async';

import 'services/api_service.dart';
import 'scrollable_tabs.dart';
import 'page.dart';
import 'loading.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learning',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: MyHomePage(
        title: 'Flutter Learning',
        analytics: analytics,
        observer: observer,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.analytics, this.observer}) : super(key: key);

  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _MyHomePageState createState() => _MyHomePageState(analytics, observer);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.analytics, this.observer);

  List newsData;
  bool loading = false;
  String _message = '';
  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final GlobalKey<_MyHomePageState> _myHomePageKey = GlobalKey<_MyHomePageState>();

  @override
  void initState() {
    super.initState();
    setState(() => loading = true);
    this.getNewsData();
  }

  void setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    await analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        'bool': true,
      },
    );
    setMessage('logEvent succeeded');
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
      return Loading(tip: 'News Coming...');
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
