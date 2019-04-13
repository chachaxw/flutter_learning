import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  Loading({ Key key, this.tip}) : super(key: key);

  final String tip;
  final Animation<Color> valueColor = new AlwaysStoppedAnimation<Color>(Colors.orange);

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(valueColor: valueColor),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(tip),
          ),
        ],
      ),
    );
  }
}