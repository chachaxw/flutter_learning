import 'package:flutter_learning/actions/counter_actions.dart';

// The reducer, which takes the previous count and increments it in response
// to an Increment action.
int counterReducer(int currentCount, action) {

  if (action is IncrementCountAction) {
    currentCount++;
    return currentCount;
  } else if (action is DecrememtCountAction) {
    currentCount--;
    return currentCount;
  } else {
    return currentCount;
  }
}