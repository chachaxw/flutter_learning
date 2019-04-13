import 'package:flutter/material.dart';

import 'pages/home.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learning',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(
        title: 'Flutter Learning',
      ),
    );
  }
}
