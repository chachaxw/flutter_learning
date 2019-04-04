import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/api_service.dart';
import 'camera.dart';
import 'dart:convert';

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

  @override
  void initState() {
    super.initState();
    this.getNewsData();
  }

  Future<void> getNewsData() async {
    setState(() => loading = true);

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
    return new Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildNewsList(BuildContext context, List<dynamic> data) {
    return new ListView.builder(
      padding: const EdgeInsets.only(top: 16.0),
      itemCount: newsData == null ? 0 : newsData.length,
      itemBuilder: (BuildContext context, int index) {
        var id = data[index]['id'];
        var url = data[index]['urlToImage'];
        var title = data[index]['title'];
        var description = data[index]['description'];

        return Card(
          key: id,
          margin: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              // Stretch the cards in horizontal axis
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.only(right: 10.0),
                  child: url != null ? Image.network(
                    url,
                    fit: BoxFit.cover,
                    alignment: Alignment.center
                  ) : Icon(
                    Icons.image,
                    color: Colors.grey,
                    size: 50.0,
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      title,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(
                      description,
                      softWrap: true,
                      maxLines: 3,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ],
                ),
              ],
            )
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
      body: loading ? _buildLoading() : _buildNewsList(context, newsData),
      floatingActionButton: FloatingActionButton(
        onPressed: _initCamera,
        tooltip: 'Camera',
        child: Icon(Icons.camera_alt),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
