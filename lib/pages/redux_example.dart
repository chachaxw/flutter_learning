import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// One simple action: Increment
enum Actions {
  Increment,
  Decrement,
}

// The reducer, which takes the previous count and increments it in response
// to an Increment action.
int counterReducer(int state, dynamic action) {
  switch (action) {
    case Actions.Increment:
      return state + 1;
    case Actions.Decrement:
      return state - 1;
    default:
      return state;
  }
}

class ReduxExample extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => ReduxExampleState();
}

class ReduxExampleState extends State<ReduxExample> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Redux Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pressed the button this many times:',
            ),
            // Connect the Store to a Text Widget that renders the current count
            new StoreConnector<int, String>(
              converter: (store) => store.state.toString(),
              builder: (context, count) {
                return Text(
                  count,
                  style: Theme.of(context).textTheme.display4,
                );
              },
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  StoreConnector<int, VoidCallback>(
                    converter: (store) {
                      return () => store.dispatch(Actions.Decrement);
                    },
                    builder: (context, callback) {
                      return RaisedButton(
                        // Attach the `callback` to the `onPressed` attribute
                        onPressed: callback,
                        shape: CircleBorder(),
                        child: Icon(Icons.remove),
                      );
                    },
                  ),
                  StoreConnector<int, VoidCallback>(
                    converter: (store) {
                      return () => store.dispatch(Actions.Increment);
                    },
                    builder: (context, callback) {
                      return RaisedButton(
                        // Attach the `callback` to the `onPressed` attribute
                        onPressed: callback,
                        shape: CircleBorder(),
                        child: Icon(Icons.add),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}