import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:flutter_learning/models/app_state.dart';
import 'package:flutter_learning/actions/counter_actions.dart';

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
            new StoreConnector<AppState, _ViewModel>(
              converter: _ViewModel.fromStore,
              builder: (context, _ViewModel vm) {
                return Text(
                  vm.count.toString(),
                  style: Theme.of(context).textTheme.display4,
                );
              },
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  StoreConnector<AppState, VoidCallback>(
                    converter: (Store<AppState> store) {
                      return () => store.dispatch(new DecrememtCountAction());
                    },
                    builder: (context, VoidCallback decrese) {
                      return RaisedButton(
                        // Attach the `decrese` to the `onPressed` attribute
                        onPressed: decrese,
                        shape: CircleBorder(),
                        color: Colors.orange,
                        padding: EdgeInsets.all(16.0),
                        child: Icon(Icons.remove, color: Colors.white),
                      );
                    },
                  ),
                  StoreConnector<AppState, VoidCallback>(
                    converter: (Store<AppState> store) {
                      return () => store.dispatch(new IncrementCountAction());
                    },
                    builder: (context, VoidCallback increse) {
                      return RaisedButton(
                        // Attach the `increse` to the `onPressed` attribute
                        onPressed: increse,
                        shape: CircleBorder(),
                        color: Colors.orange,
                        padding: EdgeInsets.all(16.0),
                        child: Icon(Icons.add, color: Colors.white),
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

class _ViewModel {
  _ViewModel({
    @required this.count
  });

  final int count;

  // This is simply a constructor method.
	// This creates a new instance of this _viewModel
	// with the proper data from the Store.
	//
	// This is a very simple example, but it lets our
	// actual counter widget do things like call 'vm.count'
  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(count: store.state.count);
  }
}