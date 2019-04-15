import 'package:flutter_learning/actions/home_actions.dart';

List<dynamic> homeReducers(List<dynamic> newsList, action) {
  if (action is LoadNewsAction) {
    return newsList;
  }

  return newsList;
}