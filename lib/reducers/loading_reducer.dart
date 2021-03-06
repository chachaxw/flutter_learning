import 'package:flutter_learning/actions/loading_actions.dart';

bool loadingReducer(bool isLoading, action) {
  if (action is LoadingStartAction) {
    return true;
  } else if (action is LoadingEndAction) {
    return false;
  } else {
    return isLoading;
  }
}