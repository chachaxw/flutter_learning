import 'package:flutter_learning/actions/counter_actions.dart';

// The reducer, which takes the previous count and increments it in response
// to an Increment action.
int counterReducer(int currentCount, action) {
  switch (action) {
    case IncrementCountAction:
      return currentCount + 1;
    case DecrememtCountAction:
      return currentCount - 1;
    default:
      return currentCount;
  }
}