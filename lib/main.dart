import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'camera.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

  void _initCamera() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CameraExample()));
  }

  Widget _buildNews(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('user').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');

        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildNewsList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildNewsList(BuildContext context, List<DocumentSnapshot> data) {
    return new ListView(
      padding: const EdgeInsets.only(top: 16.0),
      children: data.map((DocumentSnapshot document) {
        return new ListTile(
          title: new Text(document['username']),
          subtitle: new Text(document['phone']),
        );
      }).toList(),
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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
      body: _buildNews(context),
      floatingActionButton: FloatingActionButton(
        onPressed: _initCamera,
        tooltip: 'Camera',
        child: Icon(Icons.camera_alt),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
