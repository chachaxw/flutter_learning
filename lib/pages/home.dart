import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'page.dart';

import 'package:flutter_learning/services/api_service.dart';
import 'package:flutter_learning/widgets/scrollable_tabs.dart';
import 'package:flutter_learning/widgets/loading.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class Discover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text('Discover News');
  }
}

class HomePageState extends State<HomePage> {
  HomePageState();

  List newsData;
  bool loading = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final GlobalKey<HomePageState> _homePageKey = GlobalKey<HomePageState>();

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

  Widget _buildDiscover(BuildContext context, List<dynamic> newsData) {
    // print(newsData.toString());

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _handleRefresh,
      color: Colors.orange,
      child: new ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: newsData != null ? newsData.length : 0,
        itemBuilder: (BuildContext context, int index) {
          var item = newsData[index];
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('[ProductsManager State] build and loading status $loading');

    return new ScrollableTabs(
      title: Text(widget.title),
      initinalIndex: 1,
      tabsStyle: TabsStyle.iconsOnly,
      pages: [
        Page(
          icon: Icons.favorite,
          text: 'Favorite',
          body: Text('Favorite News'),
        ),
        Page(
          icon: Icons.explore,
          text: 'Discover',
          body: Discover(),
        ),
        Page(
          icon: Icons.grain,
          text: 'Hot',
          body: Text('Hot News'),
        ),
      ],
    );
  }
}