import 'dart:convert';
import 'package:redux/redux.dart';
import 'package:flutter_learning/models/app_state.dart';
import 'package:flutter_learning/services/api_service.dart';
import 'package:flutter_learning/actions/loading_actions.dart';

class LoadNewsAction {
  List<dynamic> newsList;

  LoadNewsAction({ this.newsList });
}

Future<void> getNewsListAction(Store<AppState> store) async {
  var response = await ApiService().getNewsData();
  var dataConvertedToJSON = json.decode(response.body);

  // Extract the required part and assign it to the global variable named data
  final List<dynamic> newsList = dataConvertedToJSON['articles'];

  // print(newsList);
  store.dispatch(LoadNewsAction(newsList: newsList ?? []));
  store.dispatch(LoadingEndAction());
}