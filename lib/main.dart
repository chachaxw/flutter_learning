import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/api_service.dart';
import 'dart:convert';
import 'dart:async';
import 'camera.dart';

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
      // Get the JSON data
      var dataConvertedToJSON = json.decode(response.body);
      // Extract the required part and assign it to the global variable named data
      newsData = dataConvertedToJSON['articles'];
      loading = false;
    });
  }

  void _initCamera() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CameraExample()));
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
            padding: EdgeInsets.all(12),
            child: Text('News Coming...'),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsList(BuildContext context, List<dynamic> data) {
    if (loading) {
      return _buildLoading();
    }

    return new ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 20.0),
      itemCount: newsData == null ? 0 : newsData.length,
      itemBuilder: (BuildContext context, int index) {
        var item = data[index];
        var id = item['id'];
        var url = item['urlToImage'];
        var title = item['title'];
        var description = item['description'];

        return new Card(
          key: id,
          margin: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 16.0),
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

  Widget _buildStack(BuildContext context, DocumentSnapshot document) {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage(document['avatar']),
          radius: 56,
        ),
        Text(
          document['username'],
          style: Theme.of(context).textTheme.title,
        ),
        Text(
          document['phone'],
          style: Theme.of(context).textTheme.subtitle,
        ),
        Text(
          document['email'],
          style: Theme.of(context).textTheme.subtitle,
        ),
      ],
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        color: Colors.orange,
        child: _buildNewsList(context, newsData),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _initCamera,
        tooltip: 'Camera',
        child: Icon(Icons.camera_alt),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
