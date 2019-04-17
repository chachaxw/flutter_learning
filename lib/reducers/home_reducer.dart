import 'package:flutter_learning/actions/home_actions.dart';

List<dynamic> homeReducer(List<dynamic> newsList, action) {
  if (action is LoadNewsAction) {
    return newsList = action.newsList;
  } else {
    return newsList;
  }
}