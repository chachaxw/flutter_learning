import 'package:flutter_learning/actions/loading_actions.dart';

bool loadingReducer(bool isLoading, action) {
  if (action is LoadingStartAction) {
    return !isLoading;
  } else if (action is LoadingEndAction) {
    return isLoading;
  } else {
    return isLoading;
  }
}