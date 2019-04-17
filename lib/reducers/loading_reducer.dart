import 'package:flutter_learning/actions/loading_actions.dart';

bool loadingReducer(bool isLoading, action) {
  if (action is LoadingStartAction) {
    isLoading = true;
    return isLoading;
  } else if (action is LoadingEndAction) {
    isLoading = false;
    return isLoading;
  } else {
    return isLoading;
  }
}