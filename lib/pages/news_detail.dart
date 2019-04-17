import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';

class NewsDetail extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => NewsDetailState();
}

class NewsDetailState extends State<NewsDetail> {
  final double _appBarHeight = 256.0;
  static final GlobalKey<ScaffoldState> _newsDetailKey = GlobalKey<ScaffoldState>();

  Widget _buildStack(BuildContext context, String imgUrl) {

    var backgroundImage = Image(
      fit: BoxFit.cover,
      image: new NetworkImageWithRetry(imgUrl),
    );

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: <Widget>[
        backgroundImage,
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.0, -1.0),
              end: Alignment(0.0, -0.4),
              colors: <Color>[Color(0x60000000), Color(0x00000000)],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                _newsDetailKey.currentState.showSnackBar(const SnackBar(
                  content: Text("Editing isn't supported in this screen."),
                ));
              },
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
          ),
        ),
      ],
    );
  }
}