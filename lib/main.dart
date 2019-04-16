import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:flutter_learning/models/app_state.dart';
import 'package:flutter_learning/reducers/app_reducer.dart';
import 'package:flutter_learning/widgets/navigation_bar.dart';

void main() {
  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState(),
    middleware: [
      new LoggingMiddleware.printer(),
      thunkMiddleware,
    ],
  );

  runApp(App(store: store));
}

class App extends StatelessWidget {
  final Store<AppState> store;

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
        home: NavigationBar(),
      ),
    );
  }
}
