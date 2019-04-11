import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'camera.dart';
import 'utils.dart';

enum AppBarBehavior {
  normal,
  pinned,
  floating,
  snapping,
}

class UserProfilePage extends StatefulWidget {
  final String title;

  UserProfilePage({Key key, this.title}) : super(key: key);

  @override
  UserProfileState createState() => UserProfileState();
}

class  UserProfileState extends State<UserProfilePage> {
  static final GlobalKey<UserProfileState> _userProfileKey = GlobalKey<UserProfileState>();
  final double _appBarHeight = 256.0;

  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  void _initCamera() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CameraExample()));
  }

  Widget _buildStack(BuildContext context, DocumentSnapshot document) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: <Widget>[
        Image.network(
          document['avatar'],
          fit: BoxFit.cover,
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.0, -1.0),
              end: Alignment(0.0, -0.4),
              colors: <Color>[Color(0x60000000), Color(0x00000000)],
            ),
          ),
        ),
        // CircleAvatar(
        //   backgroundImage: AssetImage('assets/images/avatar.jpg'),
        //   radius: 56,
        // ),
        // Text(
        //   document['username'],
        //   style: Theme.of(context).textTheme.title,
        // ),
        // Text(
        //   document['phone'],
        //   style: Theme.of(context).textTheme.subtitle,
        // ),
        // Text(
        //   document['email'],
        //   style: Theme.of(context).textTheme.subtitle,
        // ),
      ],
    );
  }

  Widget _buildUserStream(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('user').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return new Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return new Text('No Data');
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            DocumentSnapshot document = snapshot.data.documents[0];
            return _buildStack(context, document);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _userProfileKey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: _appBarHeight,
            pinned: _appBarBehavior == AppBarBehavior.pinned,
            floating: _appBarBehavior == AppBarBehavior.floating || _appBarBehavior == AppBarBehavior.snapping,
            snap: _appBarBehavior == AppBarBehavior.snapping,
            actions: <Widget>[],
            flexibleSpace: FlexibleSpaceBar(
              background: _buildUserStream(context),
            ),
          )
        ],
      ),
    );
  }
}