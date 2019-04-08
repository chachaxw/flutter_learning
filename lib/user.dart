import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'camera.dart';

class UserProfilePage extends StatefulWidget {
  final String title;

  UserProfilePage({Key key, this.title}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class  _UserProfileState extends State<UserProfilePage> {

  void _initCamera() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CameraExample()));
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}