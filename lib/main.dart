import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'pages/home.dart';

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

void main() {
  final store = new Store<int>(counterReducer, initialState: 0);

  runApp(App(store: store));
}

class App extends StatelessWidget {
  final Store<int> store;

  App({ this.store }) : super();

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Learning',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: HomePage(title: 'News'),
      ),
    );
  }
}
