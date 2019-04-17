import 'package:flutter_learning/models/app_state.dart';
import 'package:flutter_learning/reducers/counter_reducer.dart';
import 'package:flutter_learning/reducers/loading_reducer.dart';
import 'package:flutter_learning/reducers/home_reducer.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
    isLoading: loadingReducer(state.isLoading, action),
    count: counterReducer(state.count, action),
    newsList: homeReducer(state.newsList, action)
  );
}